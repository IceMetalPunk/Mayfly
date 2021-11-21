if (is_undefined(camera) || terrainSpeedMultiplier == 0) { exit; }

terrainOffset += terrainSpeed * terrainSpeedMultiplier;
camera_set_view_pos(camera, startViewX + terrainOffset, startViewY);
with (all) {
	if (asset_has_tags(object_index, "noScroll", asset_object)) {
		x = xstart + other.terrainOffset;	
	}
}