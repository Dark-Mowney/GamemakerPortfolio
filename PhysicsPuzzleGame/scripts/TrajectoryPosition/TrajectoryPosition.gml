/// @function This returns the x and y of the trajectory at a given time.
/// @param {real}  startX  x position the object starts at
/// @param {real}  startY  y position the object starts at
/// @param {real}  initialVelX  the x velocity of the object
/// @param {real}  initialVelY  the y velocity of the object
/// @param {real}  gravity  gravity
/// @param {real}  time  the point in time along the trajectory that you want returned.
/// @returns [x, y]
function trajectory_position(startX, startY, initialVelX, initialVelY, grav, time)
{
    var posX = startX + initialVelX * time;
    var posY = startY + initialVelY * time;
	
	posY = posY - (grav * time)
	
    return [posX, posY];
}

