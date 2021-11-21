/* TODO: Implement physics / collisions with terrain */
/* TODO 2: Implement static enemies, breakable terrain, and capture death */
/* TODO 3: Implement Action Point puzzle pop-up */

self.actTimer = 0;
self.actSeconds = 10;
self.timeSlowFactor = 0.05;
self.lastActionPoint = noone;
self.introTime = 7;

self.setState = function(state) {
	if (!is_undefined(self.state)) {
		self.state.finish(id);
	}
	self.state = state;
	state.start(id);
}

self.stateEntering = {
	start: function(player) {
		player.x = -player.sprite_width * 2;
		player.introX = player.x;
		TerrainController.terrainSpeedMultiplier = 0;	
	},
	step: function(player) {
		player.x += (player.xstart - player.introX) / (room_speed * player.introTime);
		if (player.x >= player.xstart) {
			EffectController.bwGoal = 0;
			player.setState(player.stateNormal);
		}
	},
	finish: function(player) {
		TerrainController.terrainSpeedMultiplier = 1;
	}
};


self.stateNormal = {
	start: function(player) {},
	step: function(player) {
		with (player) {
			if (!instance_exists(self.lastActionPoint) || !place_meeting(x, y, self.lastActionPoint)) {
				self.lastActionPoint = noone;	
			}
		}
		with (ActionPoint) {
			if (id != player.lastActionPoint && place_meeting(x, y, player)) {
				player.lastActionPoint = id;
				player.setState(player.stateActing);
			}
		}
	},
	finish: function(player) {}
}

self.stateActing = {
	start: function(player) {
		audio_play_sound(sfxActionPoint, 0, false);
		EffectController.bwGoal = 0.5;
		TerrainController.terrainSpeedMultiplier = player.timeSlowFactor;
		player.actTimer = room_speed * player.actSeconds;
	},
	finish: function(player) {
		audio_play_sound(sfxActionPointEnd, 0, false);
		EffectController.bwGoal = 0;
		TerrainController.terrainSpeedMultiplier = 1;
	},
	step: function(player) {
		player.actTimer = max(0, player.actTimer - 1);	
		if (player.actTimer <= 0) {
			player.setState(player.stateNormal);	
		}
	}
}

self.state = undefined;
setState(self.stateEntering);