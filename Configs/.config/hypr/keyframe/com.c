#include <gtk/gtk.h>
#include <gtk/gtkx.h>
#include <stdio.h> 
#include <stdlib.h> 

GtkBuilder      *builder;
GtkWidget       *main1;
GtkWidget       *mainframe;
GtkWidget       *header;
GtkWidget       *info;
GtkWidget       *heading;
GtkWidget       *pages;
GtkWidget       *stack1;
GtkWidget       *stack11;
GtkWidget       *buttons1;
GtkWidget       *stack2;
GtkWidget       *stack21;
GtkWidget       *buttons2;
GtkWidget       *stack3;
GtkWidget       *stack31;
GtkWidget       *buttons3;
GtkWidget       *stack4;
GtkWidget       *stack41;
GtkWidget       *buttons4;

int main (int argc, char *argv[])
{

    
    gtk_init(&argc, &argv);

    builder = gtk_builder_new();
    gtk_builder_add_from_file (builder, "~/.config/hypr/keyframe/cheatsheet.glade", NULL);

    main1 = GTK_WIDGET(gtk_builder_get_object(builder, "main1"));

    gtk_builder_connect_signals(builder, NULL);

    mainframe = GTK_WIDGET(gtk_builder_get_object(builder, "mianframe"));
    header = GTK_WIDGET(gtk_builder_get_object(builder, "header"));
    info = GTK_WIDGET(gtk_builder_get_object(builder, "info"));
    heading = GTK_WIDGET(gtk_builder_get_object(builder, "heading"));
    pages = GTK_WIDGET(gtk_builder_get_object(builder, "pages"));


    g_object_unref(builder);

    gtk_widget_show(main1);
    gtk_main();

    return 0;
}

// called when window is closed
void on_window_main_destroy()
{
    gtk_main_quit();
}
