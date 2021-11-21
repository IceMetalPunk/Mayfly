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
		player.x = -(Player.xstart - player.xstart) - Player.sprite_width * 2;
		player.introX = player.x;
	},
	step: function(player) {
		player.x += (player.xstart - player.introX) / (room_speed * player.introTime);
		if (player.x >= player.xstart) {
			player.setState(player.stateNormal);
		}
	},
	finish: function() {}
};


self.stateNormal = {
	start: function(player) {},
	step: function(player) {},
	finish: function(player) {}
}

self.state = undefined;
setState(self.stateEntering);