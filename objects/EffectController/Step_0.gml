if (self.bwGoal != self.bwCurrent) {
	self.bwCurrent = clamp(self.bwCurrent + self.bwFadeSpeed * sign(self.bwGoal - self.bwCurrent), 0, 1);
	fx_set_parameter(self.bwFx, "g_Intensity", self.bwCurrent);
}