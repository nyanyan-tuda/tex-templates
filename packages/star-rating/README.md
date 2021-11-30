# Package star-rating

- Allows displaying rating with stars

## Options

- `max-points`: Specifies the default maximum points to be achieved (Default max points = 5).
- `color-achieved`: Specifies the color of the stars, each representing the achieved points
  (Default color = Yellow).
- `color-unachieved`: Specifies the color of the stars, each representing the unachieved points
  (Default color = Gray).

## Commands

- `\stars{float}[int]`: The first argument represents the achieved points, the second argument is
  optional and represents the maximum points to be achieved (default value: see option
  `max-points`).

  Examples:
  - `\stars{2.5}[5}`: Achieved 2.5 points out of 5.
  - `\stars{2.5}`: Achieved 2.5 points out of `max-points`.
