import sys
import os
sys.path.append(os.path.join(os.path.dirname(__file__), "generated"))

import wit_world as _wit_world

# Global state for our implementation
state = {
    "x": 0.0, "y": 0.0,
    "vx": 0.0, "vy": 0.0
}

class WitWorld(_wit_world.WitWorld):
    def update(self, ax: float, ay: float, dt: float) -> None:
        # 1000 is the Force multiplier from the frontend
        # but to keep units sane inside python, let's treat ax/ay as raw units
        # and do the math.
        # Front-end sends: input.x * 1000

        # Semi-implicit Euler integration
        state["vx"] += ax * dt
        state["vy"] += ay * dt
        state["x"] += state["vx"] * dt
        state["y"] += state["vy"] * dt

    def get_x(self) -> float:
        return state["x"]

    def get_y(self) -> float:
        return state["y"]

    def get_vx(self) -> float:
        return state["vx"]

    def get_vy(self) -> float:
        return state["vy"]

    def reset(self) -> None:
        state["x"] = 0.0
        state["y"] = 0.0
        state["vx"] = 0.0
        state["vy"] = 0.0
