use gtk4::glib::property::PropertySet;
use gtk4::{
    glib, prelude::*, Application, ApplicationWindow, Box as GtkBox, Button, CssProvider, DrawingArea, Entry, Label, ScrolledWindow, 
    Orientation, Overlay, Stack, Picture, EventControllerKey
};
use gtk4::gdk::Display;
use gtk4_layer_shell::{LayerShell, Layer, Edge};
use std::process::Command;
use std::cell::Cell;
use std::rc::Rc;
use vte4::{Terminal, PtyFlags, TerminalExtManual};
use gtk4::glib::{SpawnFlags,Pid,Error };
use std::sync::{Arc, atomic::{AtomicBool, Ordering}};
use signal_hook::flag;
use std::collections::HashSet;
use std::cell::RefCell;

fn main() {
    let _ = Command::new("NetworkManager");
    let app = Application::builder()
        .application_id("ekah.scu.capsulator")
        .build();

    app.connect_activate(build_ui);
    app.run();
}

fn scan_networks() -> Vec<String> {
    let output = Command::new("nmcli")
        .args(&["-t", "-f", "SSID", "device", "wifi", "list"])
        .output()
        .expect("failed to execute nmcli");
    
    let stdout = String::from_utf8_lossy(&output.stdout);
    
    stdout.lines()
        .filter_map(|line| line.split_whitespace().next())
        .map(|ssid| ssid.to_string())
        .collect()
}


fn draw_circle_progress(cr: &gtk4::cairo::Context, percent: f64) {
    let w = 40.0;
    let h = 40.0;
    let radius = 10.0;
    let center_x = w / 2.0;
    let center_y = h / 2.0;

    // Background circle
    cr.set_source_rgba(0.2, 0.2, 0.2, 0.4);
    cr.arc(center_x, center_y, radius, 0.0, 2.0 * std::f64::consts::PI);
    cr.set_line_width(4.0);
    let _ = cr.stroke();

    // Progress arc
    cr.set_source_rgba(255.0/255.0, 155.0/255.0, 155.0/255.0, 1.0);
    let angle = percent / 100.0 * 2.0 * std::f64::consts::PI;
    cr.arc(center_x, center_y, radius, -std::f64::consts::PI / 2.0, angle - std::f64::consts::PI / 2.0);
    let _ = cr.stroke();
}

fn is_connected() -> bool {
    let output = Command::new("nmcli")
        .args(&["-t", "-f", "STATE", "general"])
        .output()
        .expect("Failed to run nmcli");

    let stdout = String::from_utf8_lossy(&output.stdout);
    stdout.trim() == "connected"
}

fn terminally_ill(boxxy: &GtkBox, argv: Vec<&str>) {
    while let Some(child) = boxxy.first_child() {
        boxxy.remove(&child);
    }

    let terminal = Terminal::new();
    terminal.set_vexpand(true);
    terminal.set_hexpand(true);

    let fg = gtk4::gdk::RGBA::new(0.4275, 0.4275, 0.4275, 1.0);
    let bg = gtk4::gdk::RGBA::new(0.7686, 0.7686, 0.7686, 1.0); 

    let palette_owned: Vec<gtk4::gdk::RGBA> = vec![
        gtk4::gdk::RGBA::new(0.00, 0.40, 0.27, 1.0),
        gtk4::gdk::RGBA::new(0.00, 0.49, 0.32, 1.0),
        gtk4::gdk::RGBA::new(0.00, 0.57, 0.38, 1.0),
        gtk4::gdk::RGBA::new(0.00, 0.66, 0.44, 1.0),
        gtk4::gdk::RGBA::new(0.00, 0.74, 0.50, 1.0),
        gtk4::gdk::RGBA::new(0.00, 0.83, 0.55, 1.0),
        gtk4::gdk::RGBA::new(0.00, 0.91, 0.61, 1.0),
        gtk4::gdk::RGBA::new(0.00, 1.00, 0.67, 1.0),
    ];
    let palette: Vec<&gtk4::gdk::RGBA> = palette_owned.iter().collect();
    terminal.set_colors(Some(&fg), Some(&bg), &palette);

    println!("{:?}", argv);

    terminal.spawn_async(
        PtyFlags::DEFAULT,
        None,
        &argv,
        &[],
        SpawnFlags::DEFAULT,
        || {},
        -1,
        None::<&gtk4::gio::Cancellable>,
        move |res: Result<Pid, Error>| {
            match res {
                Ok(pid) =>  {
                    glib::child_watch_add(pid, move |_pid, status| {
                        println!("Process exited with status {}", status);
                    });
                },
                Err(e) => eprintln!("Failed to spawn terminal process: {}", e),
            }
        }
    );

    boxxy.append(&terminal);
}

fn signally(text: &str, drawing_area: &DrawingArea, info: &Label) {
    info.set_text(text);

    let progress_values = vec![
        0.0, 5.0, 10.0, 15.0, 20.0, 25.0,
        30.0, 35.0, 40.0, 45.0,
        50.0, 55.0, 60.0, 65.0,
        70.0, 75.0, 80.0, 85.0,
        90.0, 95.0, 100.0,
    ];

    let progress = Rc::new(Cell::new(progress_values[0]));

    let progress_clone = progress.clone();
    drawing_area.set_draw_func(move |_, cr, _, _| {
        draw_circle_progress(cr, progress_clone.get());
    });

    let current_index = Rc::new(Cell::new(0));
    let drawing_area_clone = drawing_area.clone();
    let current_index_clone = current_index.clone();
    let progress_clone2 = progress.clone();

    glib::timeout_add_local(std::time::Duration::from_millis(70), move || {
        let idx = (current_index_clone.get() + 1) % progress_values.len();
        current_index_clone.set(idx);
        progress_clone2.set(progress_values[idx]);

        drawing_area_clone.queue_draw();

        glib::ControlFlow::Continue
    }); 
}

fn signally_terminato(stack: &Stack, percent: f64, next: &str, drawing_area: &DrawingArea, info: &Label){
    let drawing_area_clone = drawing_area.clone();

    let next_one = next.to_string();
    info.set_text("Till CynageOS");
    stack.set_visible_child_name(&next_one);
    drawing_area_clone.set_draw_func(move |_, cr, _, _| {
        draw_circle_progress(cr, percent);
    });
}


fn build_ui(app: &Application) {
    let window = ApplicationWindow::new(app);
    window.init_layer_shell();
    window.set_layer(Layer::Background);
    window.auto_exclusive_zone_enable();
    window.fullscreen();
    window.set_decorated(false);
    window.set_namespace(Some("welp"));

    for (edge, anchor) in [
        (Edge::Left, true),
        (Edge::Right, true),
        (Edge::Top, true),
        (Edge::Bottom, true),
    ] {
        window.set_anchor(edge, anchor);
    }

    let css = CssProvider::new();
    css.load_from_data(
        "
        window {
            background-color: rgba(0, 0, 0, 0);
        }

        #cynide {
            border-radius: 50px;
            border: 1px solid rgba(255, 255, 255, 0.12);
            background-color: rgba(19, 19, 19, 0.2);
            padding: 10px 30px 30px 30px;
            opacity: 1.0;
        }

        @keyframes retro-glow-in {
            0% {
                opacity: 0;
                text-shadow:
                    0 0 8px #11eeee,
                    0 0 20px #11bbbb,
                    0 0 36px #11aaaa,
                    0 0 64px #55ffff,
                    0 0 96px #aaffff;
            }
            50% {
                opacity: 0.7;
                text-shadow:
                    0 0 16px #55ffff,
                    0 0 36px #11eeee,
                    0 0 56px #aaffff,
                    0 0 80px #55ffff;
            }
            80% {
                opacity: 1;
                text-shadow:
                    0 0 28px #aaffff,
                    0 0 48px #55ffff,
                    0 0 68px #22dddd,
                    0 0 96px #11aaaa;
            }
            100% {
                opacity: 1;
                text-shadow:
                    0 0 4px  #aaffff,
                    0 0 8px  #55ffff,
                    0 0 12px #22dddd,
                    0 0 24px #11aaaa,
                    0 0 36px #11bbbb,
                    0 0 48px #11eeee;
            }
        }

        @keyframes retro-glow-loop {
            0% {
                opacity: 1;
                text-shadow:
                    0 0 4px  #aaffff,
                    0 0 8px  #55ffff,
                    0 0 12px #22dddd,
                    0 0 24px #11aaaa,
                    0 0 36px #11bbbb,
                    0 0 48px #11eeee;
            }
            50% {
                opacity: 1;
                text-shadow:
                    0 0 28px #aaffff,
                    0 0 48px #55ffff,
                    0 0 68px #22dddd,
                    0 0 96px #11aaaa;
            }
            80% {
                opacity: 0.7;
                text-shadow:
                    0 0 16px #55ffff,
                    0 0 36px #11eeee,
                    0 0 56px #aaffff,
                    0 0 80px #55ffff;
            }
            100% {
                opacity: 0;
                text-shadow:
                    0 0 8px #11eeee,
                    0 0 20px #11bbbb,
                    0 0 36px #11aaaa,
                    0 0 64px #55ffff,
                    0 0 96px #aaffff;
            }
        }

        label.eye {
            letter-spacing: 1px;
            line-height: 0.5;
            font-size: 12px;
            color: #aaffff;
            font-weight: bold;
            text-shadow:
                0 0 4px  #aaffff,
                0 0 8px  #55ffff,
                0 0 12px #22dddd,
                0 0 24px #11aaaa,
                0 0 36px #11bbbb,
                0 0 48px #11eeee;
            background: transparent;
            padding: 2px 16px;
            border-radius: 9px;
            font-family: 'Orbitron', 'Segoe UI', monospace;
            opacity: 0;
            animation: 
                retro-glow-in 2s cubic-bezier(0.6,0,0.4,1) forwards;
        }

        label.aftereye {
            letter-spacing: 1px;
            line-height: 0.5;
            font-size: 12px;
            color: #aaffff;
            font-weight: bold;
            text-shadow:
                0 0 4px  #aaffff,
                0 0 8px  #55ffff,
                0 0 12px #22dddd,
                0 0 24px #11aaaa,
                0 0 36px #11bbbb,
                0 0 48px #11eeee;
            background: transparent;
            padding: 2px 16px;
            border-radius: 9px;
            font-family: 'Orbitron', 'Segoe UI', monospace;
            opacity: 1;
            animation:             
                retro-glow-loop 2s cubic-bezier(0.6,0,0.4,1) forwards;
        }

        #heading {
            font-size: 28px;
            font-weight: 900;
            color: rgba(204, 204, 204, 1);
        }

        #mainbox {
            border-radius: 25px;
            border: 1px solid rgba(255, 255, 255, 0.16);
            background-color: rgba(40, 54, 45, 0.32);
            padding: 30px 30px 30px 30px;
        }

        #inbox {
            border-radius: 25px;
            border: 1px solid rgba(255, 255, 255, 0.16);
            background-color: rgba(49, 49, 49, 0.56);
            padding: 30px 30px 30px 30px;
        }

        #inbox-dark {
            border-radius: 25px;
            border: 1px solid rgba(255, 255, 255, 0.16);
            background-color: rgba(196, 196, 196, 1);
            padding: 30px 30px 30px 30px;
        }

        #progressbox{
            border-radius: 50px;
            border: 1px solid rgba(255, 255, 255, 0.16);
            background-color: rgba(255, 255, 255, 0.32);
            padding: 0px 0px 0px 10px;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
        }

        .wifi-entry {
            all: unset;
            padding: 10px;
            font-size: 18px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.16);
            background-color: rgba(59, 59, 59, 0.41);
            color: rgba(255, 255, 255, 1);
        }

        .wifi-selected {
            all: unset;
            padding: 10px;
            font-size: 18px;
            border-radius: 20px 20px 0px 0px;
            border: 1px 1px 0px 1px solid rgba(255, 255, 255, 0.16);  
            background-color: rgba(59, 59, 59, 0.41);
            color: rgba(255, 255, 255, 1);
        }

        .wifi-entry-pass {
            padding: 5px;
            padding-left: 10px;
            font-size: 16px;
            border-radius: 0px 0px 20px 20px;
            border: 1px 1px 1px 1px solid rgba(255, 255, 255, 0.16);
            background-color: rgba(59, 59, 59, 0.41);\
            color: rgba(255, 255, 255, 1);
        }

        #wifiscr scrollbar {
            all: unset;
            background-color: transparent;
            border-radius: 12px;
            margin: 2px;
            min-width: 6px;
            min-height: 6px;
        }

        #wifiscr scrollbar slider {
            background-color: rgba(255, 255, 255, 0.15);
            border-radius: 6px;
            transition: background-color 150ms ease;
        }

        #wifiscr scrollbar:hover slider {
            background-color: rgba(255, 255, 255, 0.25);
        }

        #wifiscr scrollbar.vertical {
            margin-left: 12px;
            margin-top: 50px;
            margin-bottom: 50px;
        }

        #wifiscr scrollbar.horizontal {
            margin-top: 2px;
        }

        #error {
            color: rgba(255, 99, 99, 1);
        }

        button {
            all:unset;
            padding: 10px;
            background-color: rgba(46, 46, 46, 1);
            color: rgba(134, 134, 134, 1);
            border-radius: 15px;
            box-shadow: rgba(43, 43, 43, 0.2) 0px 0px 0px 2px, 
            rgba(41, 41, 41, 0.17) 0px 4px 6px -1px, 
            rgba(255, 255, 255, 0.04) 0px 1px 0px inset;
        }

        button:hover {
            background-color: rgba(110, 110, 110, 1);
            color: rgba(255, 255, 255, 1);
        }

        .bob-target { 
            all: unset;
            color: white;
            background-color: rgba(43, 43, 43, 1);
            padding: 10px;
            border-radius: 15px;
            caret-color: white;
            outline: none;
        }

        #ter_text {
            color: rgba(109, 109, 109, 1);
        }

        #info {
            color: rgba(0, 0, 0, 1);
        }

        .caps {
            min-height: 40px;
            padding: 10px;
            padding-right: 15px; 
            padding-left: 15px;
            border-radius: 50px;
            background: rgba(92, 92, 92, 0.25);
            border: 0.5px solid rgba(255, 255, 255, 0.18);
            box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px, 
                rgba(0, 0, 0, 0.12) 0px -12px 30px, 
                rgba(0, 0, 0, 0.12) 0px 4px 6px, 
                rgba(0, 0, 0, 0.17) 0px 12px 13px, 
                rgba(0, 0, 0, 0.09) 0px -3px 5px;
        }

        .caps-btn {
            all: unset;
            background: rgba(0, 0, 0, 0);
            padding: 10px;
            padding-right: 30px;
            padding-left: 30px;
            border-radius: 50px;
            margin: 10px;
            transform: scale(1.0);
            transition: background 0.2s ease, transform 0.2s ease;
            font-size: 16px;
            font-weight: 500;
            color: rgba(255, 255, 255, 1);
        }

        #done-txt {
            color: rgba(219, 219, 219, 1);
            font-size: 30px;
            font-weight: 200;
        }

        .none {
            all: unset;
        }
        
        ",
    );

    gtk4::style_context_add_provider_for_display(
        &Display::default().unwrap(),
        &css,
        gtk4::STYLE_PROVIDER_PRIORITY_APPLICATION,
    );

    // ---------------------------------------------------------------- MAINS
    let main_box = GtkBox::new(Orientation::Vertical, 0);
    main_box.set_hexpand(true);
    main_box.set_vexpand(true);
    main_box.set_widget_name("mainbox");
    main_box.set_valign(gtk4::Align::Fill);
    main_box.set_halign(gtk4::Align::Fill);
    main_box.set_margin_bottom(20);
    main_box.set_margin_end(20);
    main_box.set_margin_start(20);
    main_box.set_margin_top(20);
    main_box.set_visible(false);

    let stack = Stack::builder()
        .hexpand(true)
        .vexpand(true)
        .transition_type(gtk4::StackTransitionType::Crossfade)
        .build();
    let stack_box = GtkBox::new(Orientation::Horizontal, 5);
    stack_box.set_hexpand(true);
    stack_box.set_vexpand(true);

    let progressbox = GtkBox::new(Orientation::Horizontal, 5);
    progressbox.set_widget_name("progressbox");
    progressbox.set_vexpand(true);
    progressbox.set_hexpand(true);
    progressbox.set_valign(gtk4::Align::End);
    progressbox.set_halign(gtk4::Align::Center);
    let info = Label::new(Some("Till cynageOS"));
    info.set_widget_name("info");
    progressbox.append(&info);
    progressbox.set_visible(false);

    let drawing_area = DrawingArea::builder()
        .content_width(40)
        .content_height(40)
        .build();

    drawing_area.set_draw_func(move |_, cr, _, _| {
        draw_circle_progress(cr, 0.0);
    });


    // ---------------------------------------------------------------- 1s page

    let wifibox = GtkBox::new(Orientation::Vertical, 5);
    wifibox.set_widget_name("inbox");
    wifibox.set_vexpand(true);
    wifibox.set_hexpand(false);
    // wifibox.set_size_request(300, 300);
    wifibox.set_margin_end(20);
    wifibox.set_margin_top(30);
    wifibox.set_valign(gtk4::Align::Fill);
    wifibox.set_halign(gtk4::Align::Center);

    wifibox.append(&Label::builder()
        .name("heading")
        .label("Internet is Required")
        .justify(gtk4::Justification::Left)
        .build()
    );
    
    let wifibox_entries = GtkBox::new(Orientation::Vertical, 0);
    let wifiscroller = ScrolledWindow::new();
    wifiscroller.set_vexpand(true);
    wifiscroller.set_hexpand(true);
    wifiscroller.set_widget_name("wifiscr");
    wifiscroller.set_child(Some(&wifibox_entries));
    wifibox.append(&wifiscroller);
    let appendinto_wifibox = |boxxy: GtkBox, error: Label, stack: Stack| {
        while let Some(child) = boxxy.first_child() {
            boxxy.remove(&child);
        }

        let networks = scan_networks();
        let error_clone = error.clone();
        for ssid in networks {
            let ssid_for_connecting = ssid.to_string();
            let name = ssid.to_string();
            let entry = &Button::builder()
                .css_classes(["wifi-entry"])
                .label(ssid)
                .margin_top(10)
                .build();
            let entry_clone = entry.clone();
            boxxy.append(entry);
            let pass = &Entry::builder()
                .name(name)
                .placeholder_text("  Enter Password")
                .css_classes(["wifi-entry-pass"])
                .visibility(true)
                .visible(false)
                .build();
            let pass_clone = pass.clone();
            boxxy.append(pass);

            let boxxy_clone = boxxy.clone();
            entry_clone.connect_clicked(move |ent| {
                let mut child = boxxy_clone.first_child();
                while let Some(widget) = child {
                    if let Some(button) = widget.downcast_ref::<Button>() {
                        button.remove_css_class("wifi-selected");
                        button.add_css_class("wifi-entry");
                    } else if let Some(entry) = widget.downcast_ref::<Entry>() {
                        entry.set_visible(false);
                    }
                    child = widget.next_sibling();
                }
                ent.remove_css_class("wifi-entry");
                ent.add_css_class("wifi-selected");
                pass_clone.set_visible(true);
            }); 

            let error_clone_inner = error_clone.clone();
            let stack_clone = stack.clone();
            pass.connect_activate(move |entry| {
                error_clone_inner.set_text("connecting...");
                let password = entry.text();
                let status = Command::new("nmcli")
                    .args(&["device", "wifi", "connect", &ssid_for_connecting, "password", &password])
                    .status()
                    .expect("Failed to execute nmcli");
                if status.success() {
                    error_clone_inner.set_text("connection successfull");
                    stack_clone.set_visible_child_name("intro");
                } else {
                    error_clone_inner.set_text("Failed to connect");
                }

            });
        }

    };

    let error = Label::new(Some(""));
    error.set_widget_name("error");
    wifibox.append(&error);

    let refresh = Button::builder()
        .icon_name("view-refresh-symbolic")
        .build();

    let error_clone = error.clone();
    let wifibox_entries_clone = wifibox_entries.clone();
    let stack_clone = stack.clone();
    refresh.connect_clicked(move |_| {
        appendinto_wifibox(wifibox_entries_clone.clone(), error_clone.clone(), stack_clone.clone());
        error_clone.clone().set_text("");
    });

    let stack_clone = stack.clone();
    appendinto_wifibox(wifibox_entries, error, stack_clone.clone());
    wifibox.append(&refresh);
    stack.add_named(&wifibox, Some("wifi"));
    stack.set_visible_child_name("wifi");

    // ---------------------------------------------------------------- 2n page
    let up_box = GtkBox::new(Orientation::Vertical, 5);
    up_box.set_vexpand(true);
    up_box.set_hexpand(true);
    // up_box.set_size_request(500, 500);
    up_box.set_valign(gtk4::Align::Center);
    up_box.set_halign(gtk4::Align::Center);

    let file = gtk4::gio::File::for_path("/var/lib/cos/intro.png");

    let picture = Picture::for_file(&file);
    picture.set_valign(gtk4::Align::Center);
    picture.set_halign(gtk4::Align::Center);
    picture.set_hexpand(true);    
    picture.set_vexpand(true);

    let start = Button::builder()
        // .child(&Label::new(Some("Begin installation")))
        .child(&picture)
        .css_classes(&["none"])
        .hexpand(true)
        .vexpand(true)
        .halign(gtk4::Align::Center)
        .valign(gtk4::Align::Center)
        .margin_bottom(20)
        .build();

    up_box.append(&start);
    stack.add_named(&up_box, Some("intro"));
    if is_connected(){
        stack.set_visible_child_name("intro");
    }
    
    // ---------------------------------------------------------------- 3r page
    let break_flag = Arc::new(AtomicBool::new(false));
    let pacman = GtkBox::new(Orientation::Vertical, 5);
    pacman.set_widget_name("inbox-dark");
    pacman.set_vexpand(true);
    pacman.set_hexpand(true);
    // pacman.set_size_request(500, 500);
    pacman.set_valign(gtk4::Align::Center);
    pacman.set_halign(gtk4::Align::Center);

    let stack_clone = stack.clone();
    let pacman_clone = pacman.clone();
    let drawing_area_clone = drawing_area.clone();
    let info_clone = info.clone();
    let progressbox_clone = progressbox.clone();
    start.connect_clicked(move |_| {
        progressbox_clone.set_visible(true);
        stack_clone.set_visible_child_name("pacman");        
        let argv = vec!["bash", "-c", "sudo pacman -Sy && sudo pacman -Sy archlinux-keyring && pidof cap | xargs kill -34"];
        signally( "updating pacman keyrings", &drawing_area_clone, &info_clone);
        terminally_ill(
            &pacman_clone,
            argv
        );
    });

    stack.add_named(&pacman, Some("pacman"));

    // ---------------------------------------------------------------- 4t page
    let part = GtkBox::new(Orientation::Vertical, 5);
    part.set_widget_name("inbox-dark");
    part.set_vexpand(true);
    part.set_hexpand(true);
    // part.set_size_request(500, 700);
    part.set_valign(gtk4::Align::Center);
    part.set_halign(gtk4::Align::Center);
    stack.add_named(&part, Some("partinfo"));
    part.append(&Label::new(Some("Loading...")));

    let to_formartpart = Button::builder()
        .label("\"I Hav Followed All The Instructions :)\"")
        .vexpand(true)
        .hexpand(true)
        .valign(gtk4::Align::End)
        .halign(gtk4::Align::Fill)
        .build();

    to_formartpart.connect_clicked(move |_|{
        let _ = Command::new("bash")
        .arg("-c")
        .arg("pidof cap | xargs kill -35")
        .spawn();
    });

    let stack_clone_4th = stack.clone();
    let break_flag_clone_4th = break_flag.clone();
    let drawing_area_clone = drawing_area.clone();
    let info_clone = info.clone();
    glib::timeout_add_local(std::time::Duration::from_secs(2), move ||{
        if stack_clone_4th.visible_child_name() == Some("partinfo".into()) {
            break_flag_clone_4th.set(false);
            let argv = vec!["bash"];
            signally("Waiting for user", &drawing_area_clone, &info_clone);
            terminally_ill(
                &part,
                argv
            );
            let part_label = Label::builder()
                .label("use <lsblk> to check the disks\nand <cfdisk> to create partitions\nMake atleast 800M for boot (EFI partiton)\nand swap (linux swap) if desired and rest for root (linux filesystem)\nswap is optional.\nPlease refer to capsulator github (https://github.com/ekahPruthvi/capsulator/blob/main/README.md)")
                .name("ter_text") 
                .build();
            part.append(&part_label);
            part.append(&to_formartpart);
            return glib::ControlFlow::Break;
        }
        glib::ControlFlow::Continue
    });

    // ---------------------------------------------------------------- 5t page
    let format = GtkBox::new(Orientation::Horizontal, 5);
    format.set_widget_name("inbox-dark");
    format.set_vexpand(true);
    format.set_hexpand(true);
    // format.set_size_request(900, 500);
    format.set_valign(gtk4::Align::Center);
    format.set_halign(gtk4::Align::Center);
    stack.add_named(&format, Some("formatpart"));

    let makepart = Button::builder()
        .child(&Label::new(Some("Begin partition formating")))
        .hexpand(true)
        .vexpand(true)
        .halign(gtk4::Align::End)
        .valign(gtk4::Align::End)
        .margin_bottom(10)
        .margin_top(10)
        .build();

    let bootentry = Entry::new();
    bootentry.set_width_request(400);
    bootentry.set_css_classes(&["bob-target"]);
    bootentry.set_placeholder_text(Some("Enter boot path (/dev/nvme0n1p*)"));

    let rootentry = Entry::new();
    rootentry.set_width_request(400);
    rootentry.set_css_classes(&["bob-target"]);
    rootentry.set_placeholder_text(Some("Enter root path (/dev/nvme0n1p*)"));

    let swapentry = Entry::new();
    swapentry.set_width_request(400);
    swapentry.set_css_classes(&["bob-target"]);
    swapentry.set_placeholder_text(Some("Enter Swap path (optional)"));

    let lsblk = Label::new(Some("Loading..."));
    lsblk.set_wrap(true);
    lsblk.set_hexpand(true);
    lsblk.set_width_request(400);
    lsblk.set_halign(gtk4::Align::Start);
    lsblk.set_justify(gtk4::Justification::Left);
    lsblk.set_widget_name("ter_text");

    let partbox = GtkBox::new(Orientation::Vertical, 5);
    partbox.set_vexpand(true);
    partbox.set_valign(gtk4::Align::Center);
    partbox.append(&bootentry);
    partbox.append(&rootentry);
    partbox.append(&swapentry);
    partbox.append(&makepart);


    format.append(&lsblk);
    format.append(&partbox);

    let stack_clone = stack.clone();
    let lsblk_clone = lsblk.clone();

    glib::timeout_add_local(std::time::Duration::from_secs(2), move ||{
        if stack_clone.visible_child_name() == Some("formatpart".into()) {
            let output = Command::new("lsblk")
                .output()
                .expect("Failed to execute lsblk");
            let output_str = String::from_utf8_lossy(&output.stdout);

            lsblk_clone.set_text(&output_str);

            return glib::ControlFlow::Break;
        }
        glib::ControlFlow::Continue
    });

    // ---------------------------------------------------------------- 6t page
    let mount = GtkBox::new(Orientation::Horizontal, 5);
    mount.set_widget_name("inbox-dark");
    mount.set_vexpand(true);
    mount.set_hexpand(true);
    // mount.set_size_request(900, 500);
    mount.set_valign(gtk4::Align::Center);
    mount.set_halign(gtk4::Align::Center);

    stack.add_named(&mount, Some("mount"));

    let stack_clone_6th = stack.clone();
    let mnt_clone = mount.clone();
    let drawing_area_clone = drawing_area.clone();
    let info_clone = info.clone();
    makepart.connect_clicked(move |_| {
        let rtpr = rootentry.text().to_string();
        let btpr = bootentry.text().to_string();
        let swppr = swapentry.text().to_string();
        stack_clone_6th.set_visible_child_name("mount");        
        let argv = vec!["/usr/bin/archincos.sh", &rtpr, &btpr, &swppr];
        signally("mounting filesystems", &drawing_area_clone, &info_clone);
        terminally_ill(
            &mnt_clone,
            argv
        );
    });

    // ---------------------------------------------------------------- 7t page
    let fsgen = GtkBox::new(Orientation::Horizontal, 5);
    fsgen.set_widget_name("inbox-dark");
    fsgen.set_vexpand(true);
    fsgen.set_hexpand(true);
    // fsgen.set_size_request(900, 500);
    fsgen.set_valign(gtk4::Align::Center);
    fsgen.set_halign(gtk4::Align::Center);

    stack.add_named(&fsgen, Some("generatefs"));

    let stack_clone = stack.clone();
    let fsgen_clone = fsgen.clone();
    let drawing_area_clone = drawing_area.clone();
    let info_clone = info.clone();
    glib::timeout_add_local(std::time::Duration::from_secs(2), move ||{
        if stack_clone.visible_child_name() == Some("generatefs".into()) {    
            let argv = vec!["bash", "/usr/bin/cynsetupcos.sh"];
            signally("Installing Dependencies", &drawing_area_clone, &info_clone);
            terminally_ill(
                &fsgen_clone,
                argv
            );
            return glib::ControlFlow::Break;
        }
        glib::ControlFlow::Continue
    });

    // ---------------------------------------------------------------- 8t page
    let done = GtkBox::new(Orientation::Vertical, 5);
    // done.set_widget_name("inbox-dark");
    done.set_vexpand(true);
    done.set_hexpand(true);
    done.set_valign(gtk4::Align::Center);
    done.set_halign(gtk4::Align::Fill);

    stack.add_named(&done, Some("done"));
    let capsule = GtkBox::new(Orientation::Horizontal, 5);
    capsule.set_css_classes(&["caps"]);
    capsule.set_halign(gtk4::Align::Center);

    done.append(
        &Label::builder()
            .name("done-txt")
            .label("INSTALLATION COMPLETE")
            .margin_bottom(50)
            .build()
    );

    done.append(&capsule);
    let shut = Button::builder()
        .css_classes(["caps-btn","def"])
        .label("ShutDown")
        .build();
    let re = Button::builder()
        .css_classes(["caps-btn"])
        .label("Restart and use COS")
        .build();
    capsule.append(&shut);
    capsule.append(&re);

    shut.connect_clicked(move |_|{
        let _ = Command::new("systemctl")            
            .arg("poweroff")
            .spawn();
    });

    re.connect_clicked(move |_|{
        let _ = Command::new("systemctl")
            .arg("reboot")
            .spawn();
    });  

    // ---------------------------------------------------------------- main shi
    stack_box.append(&stack);
    main_box.append(&stack_box);
    
    progressbox.append(&drawing_area);
    main_box.append(&progressbox);

    let overlay = Overlay::new();

    let eye = Label::new(Some("
  ⢠⣿⣯⠦⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠈⠂⠀⠀⠀⠀⠀⠀⠀⠑⠐⠀⠀⠀⠀⠀⠀⠸⡀ \n
  ⡿⣭⡦⠗⠁⠄⠂⠀⠀⠀⠀⠀⡠⣰⢀⠀⠀⠀⢰⠋⡆⢀⢠⠀⠀⠀⠀⠀⠐⢆⠀⢂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠁⠀\n
 ⠘⣼⣎⠕⠊⠁⠀⠀⠀⢢⠆⡀⠬⡑⢿⣻⡆⠀⡀⡄⠄⣧⢸⡈⢀⠀⡆⢠⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n
⡇⠸⡩⡠⡔⢱⢀⠰⣄⠔⠁⣻⣢⢙⣿⣼⣿⣷⠴⠿⣿⡗⣟⣿⡿⣷⣾⣤⣼⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n
⠁⠈⠔⢱⢌⢿⢢⠑⠻⣗⠎⣀⣿⣟⢛⣍⣯⣿⣧⣤⣿⣧⣿⣿⣵⣾⣿⣎⡹⠿⣿⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n
⠀⠀⠀⠀⢾⢱⣷⣷⡢⢾⣷⢯⣽⣽⣿⣿⠿⣿⣛⡿⠯⠿⠿⠿⡿⠿⣿⣿⣿⣿⣿⣿⣽⣟⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n
⠀⠀⢀⠑⢬⣧⣻⣽⣽⣿⣿⣿⣿⢟⣻⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠿⣽⢿⡙⢿⣿⣿⣇⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n
⠀⠀⠈⠳⢜⢿⣿⣿⢿⣿⣿⡿⣩⠋⠄⠀⠀⠀⠀⠀⣀⣠⣤⣤⣤⣤⣄⡀⠀⠀⠈⠻⣮⡟⠙⠹⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀\n
⠀⠀⢀⢀⡀⠉⢟⡻⢛⣿⠿⡷⠁⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠹⣿⣷⣦⣱⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀\n
⠀⠀⠀⠉⠚⣋⠶⣋⡵⢏⣰⠁⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀\n
⠀⠀⠀⢬⣷⣶⣽⣿⣦⡉⢡⠀⠀⠀⠀⠀⣾⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣷⢄⡀⠀⠀\n
⠀⠀⠀⡨⠟⠉⠉⣉⠻⣿⡌⢆⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢔⣿⣽⣿⣿⣿⣿⣿⣤⠑⢶⡄\n
⠀⠀⠐⠁⠀⢠⡪⠒⣚⣻⣶⣄⠳⣠⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠐⣾⣿⣿⣿⣿⣿⣿⣿⣿⣱⣼⣯\n
⠀⠀⠀⢀⣔⢡⡴⢛⣳⡼⠿⢿⣧⣬⣑⠤⣀⡀⠉⠻⢿⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⣀⣀⣤⣾⣿⣿⣿⡿⣿⣿⠿⠿⢿⢿⡿⠠\n
⠀⠀⠀⠉⠊⡝⠨⠋⠀⢀⡤⣾⣟⡻⣿⢷⣶⣬⣭⣐⣤⣄⢀⣈⣀⠀⡠⢄⡦⣤⡛⠩⣿⢛⣻⢿⢛⡼⠾⠝⡅⠭⠪⠴⠋⠀⠀\n
⠀⠀⠀⠀⠀⠀⠀⢠⠖⢛⢜⡩⠔⠋⣉⢔⠟⢪⡿⣫⠛⢿⣿⣿⡧⠉⣿⠎⠺⣾⠁⠃⣻⠑⠠⠂⠑⢒⢁⠤⠐⡄⠉⠀⠀⠀⠀\n
⠀⠀⠀⠀⠀⠀⠐⠁⠀⠉⠁⠀⠀⣪⠼⠃⢠⠿⠈⢼⢀⣾⠯⢿⠂⢑⢸⠢⠂⠃⠀⠀⠐⡘⠄⢠⠔⠓⢙⡥⠋⠀⠀⠀⠀⠀⠀\n
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠉⠀⠀⠇⠀⠃⠀⠘⢀⢉⠁⢀⢀⠀⡀⠀⠀⢔⠺⢽⠪⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀\n
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⡀⢀⡅⠤⠀⠈⢤⠐⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡐⠈⠰⠓⢀⠄⠇⠺⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠁⠀⠀⠀⠴⠠⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"));
    eye.set_css_classes(&["eye"]);
    eye.is_selectable();
    overlay.add_overlay(&main_box);
    overlay.set_child(Some(&eye));
    eye.set_margin_top(50);

    eye.set_halign(gtk4::Align::Center);
    eye.set_valign(gtk4::Align::Center);

    let main_box_clone = main_box.clone();
    glib::timeout_add_local(std::time::Duration::from_secs(4), move || {
        eye.remove_css_class("eye");
        eye.add_css_class("aftereye");
        let main_box_clone_inner = main_box_clone.clone();
        glib::timeout_add_local(std::time::Duration::from_secs(2), move || {
            main_box_clone_inner.set_visible(true);
            glib::ControlFlow::Break
        });
        glib::ControlFlow::Break
    });

    window.set_child(Some(&overlay));
    window.show();


    // ---------------------------------------------------------------- SIGNALS
    let sigrtmin = libc::SIGRTMIN();
    let sig1 = Arc::new(AtomicBool::new(false));
    let sig2 = Arc::new(AtomicBool::new(false));
    let sig3 = Arc::new(AtomicBool::new(false));
    let sig4 = Arc::new(AtomicBool::new(false));
    let sig5 = Arc::new(AtomicBool::new(false));
    let sig6 = Arc::new(AtomicBool::new(false));
    let sig7 = Arc::new(AtomicBool::new(false));
    let sig8 = Arc::new(AtomicBool::new(false));

    let _ = flag::register(sigrtmin as i32, Arc::clone(&sig1));
    let _ = flag::register(sigrtmin as i32 + 1, Arc::clone(&sig2));
    let _ = flag::register(sigrtmin as i32 + 2, Arc::clone(&sig3));
    let _ = flag::register(sigrtmin as i32 + 3, Arc::clone(&sig4));
    let _ = flag::register(sigrtmin as i32 + 4, Arc::clone(&sig5));
    let _ = flag::register(sigrtmin as i32 + 5, Arc::clone(&sig6));
    let _ = flag::register(sigrtmin as i32 + 6, Arc::clone(&sig7));
    let _ = flag::register(sigrtmin as i32 + 7, Arc::clone(&sig8));

    gtk4::glib::timeout_add_seconds_local(1, move || {
        if sig1.swap(false, Ordering::Relaxed) {
            println!("Received signal 34 for termination and move to page 4");
            signally_terminato(&stack, 10.0, "partinfo", &drawing_area, &info);
        }
        if sig2.swap(false, Ordering::Relaxed) {
            println!("Received signal 35 for terminaltion and move to page 5");
            signally_terminato(&stack, 20.0, "formatpart", &drawing_area, &info);
        }
        if sig3.swap(false, Ordering::Relaxed) {
            println!("Received signal 36 for terminaltion and move to page 6");
            signally_terminato(&stack, 30.0, "generatefs", &drawing_area, &info);
        }
        if sig4.swap(false, Ordering::Relaxed) {
            println!("Received signal 37 for info text change");
            info.set_text("Setting User Details");
        }
        if sig5.swap(false, Ordering::Relaxed) {
            println!("Received signal 38 for info text change");
            info.set_text("Theming CynageOS");
        }
        if sig6.swap(false, Ordering::Relaxed) {
            println!("Received signal 39 for termination and move to last page");
            signally_terminato(&stack, 100.0, "done", &drawing_area, &info);
        }
        if sig7.swap(false, Ordering::Relaxed) {
            println!("Received signal 40 ");
        }
        if sig8.swap(false, Ordering::Relaxed) {
            println!("Received signal 41 ");
        }
        glib::ControlFlow::Continue
    });

}