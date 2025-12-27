#ifndef WLR_RENDER_DRM_SYNCOBJ_H
#define WLR_RENDER_DRM_SYNCOBJ_H

#include <stdbool.h>
#include <stdint.h>
#include <wayland-server-core.h>

/**
 * A synchronization timeline.
 *
 * Timelines are used to synchronize accesses to buffers. Given a producer
 * (writing contents to a buffer) and a consumer (reading from the buffer), the
 * compositor needs to synchronize back-and-forth between these two users. The
 * consumer needs to wait for the producer to signal that they're done with the
 * writes, and the producer needs to wait for the consumer to signal that
 * they're done with the reads.
 *
 * Timelines provide synchronization points in the form of monotonically
 * increasing 64-bit integer values.
 *
 * wlroots timelines are designed after Vulkan timeline semaphores. For more
 * information on the Vulkan APIs, see:
 * https://www.khronos.org/blog/vulkan-timeline-semaphores
 *
 * wlroots timelines are powered by DRM synchronization objects (drm_syncobj):
 * https://dri.freedesktop.org/docs/drm/gpu/drm-mm.html#drm-sync-objects
 */
struct wlr_drm_syncobj_timeline {
	int drm_fd;
	uint32_t handle;

	// private state

	size_t n_refs;
};

struct wlr_drm_syncobj_timeline_waiter {
	struct {
		struct wl_signal ready;
	} events;

	// private state

	int ev_fd;
	struct wl_event_source *event_source;
};

/**
 * Create a new synchronization timeline.
 */
struct wlr_drm_syncobj_timeline *wlr_drm_syncobj_timeline_create(int drm_fd);
/**
 * Import a timeline from a drm_syncobj FD.
 */
struct wlr_drm_syncobj_timeline *wlr_drm_syncobj_timeline_import(int drm_fd,
	int drm_syncobj_fd);
/**
 * Reference a synchronization timeline.
 */
struct wlr_drm_syncobj_timeline *wlr_drm_syncobj_timeline_ref(struct wlr_drm_syncobj_timeline *timeline);
/**
 * Unreference a synchronization timeline.
 */
void wlr_drm_syncobj_timeline_unref(struct wlr_drm_syncobj_timeline *timeline);
/**
 * Check if a timeline point has been signalled or has materialized.
 *
 * Flags can be:
 *
 * - DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT to wait for the point to be
 *   signalled
 * - DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE to only wait for a fence to
 *   materialize
 */
bool wlr_drm_syncobj_timeline_check(struct wlr_drm_syncobj_timeline *timeline,
	uint64_t point, uint32_t flags, bool *result);
/**
 * Asynchronously wait for a timeline point.
 *
 * See wlr_drm_syncobj_timeline_check() for a definition of flags.
 */
bool wlr_drm_syncobj_timeline_waiter_init(struct wlr_drm_syncobj_timeline_waiter *waiter,
	struct wlr_drm_syncobj_timeline *timeline, uint64_t point, uint32_t flags,
	struct wl_event_loop *loop);
/**
 * Cancel a timeline waiter.
 */
void wlr_drm_syncobj_timeline_waiter_finish(struct wlr_drm_syncobj_timeline_waiter *waiter);
/**
 * Export a timeline point as a sync_file FD.
 *
 * The returned sync_file will be signalled when the provided point is
 * signalled on the timeline.
 *
 * This allows inter-operation with other APIs which don't support drm_syncobj
 * yet. The synchronization point needs to have already materialized:
 * wait-before-signal is not supported.
 */
int wlr_drm_syncobj_timeline_export_sync_file(struct wlr_drm_syncobj_timeline *timeline,
	uint64_t src_point);
/**
 * Import a timeline point from a sync_file FD.
 *
 * The provided timeline point will be signalled when the provided sync_file is.
 *
 * This allows inter-operation with other APIs which don't support drm_syncobj
 * yet.
 */
bool wlr_drm_syncobj_timeline_import_sync_file(struct wlr_drm_syncobj_timeline *timeline,
	uint64_t dst_point, int sync_file_fd);

#endif
