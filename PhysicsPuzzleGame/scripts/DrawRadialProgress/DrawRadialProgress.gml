// @function                 DrawRadialProgress(xpos,ypos,currentvalue,maxvalue,color,radius,alpha,width)
/// @param {real}  xpos  x position to draw the circle at
/// @param {real}  ypos  y position to draw the circle at
/// @param {real}  currentvalue  the current value that the progress circle should be showing
/// @param {real}  maxvalue  the max value that the progress circle can be
/// @param {color}  color  The color to draw the circle
/// @param {real}  radius  The radius of the circle
/// @param {real}  alpha  The alpha of the circle
/// @description              Draw a radial progress circle
function DrawRadialProgress(xpos,ypos,currentvalue,maxvalue,color,radius,alpha)
{
	if(currentvalue>0)
	{
		var i, len, tx, ty, val
		var numOfSections = 60
		var sizeOfSections = 360/numOfSections
		
		val = (currentvalue/maxvalue) * numOfSections
		
		if(val > 1)
		{
			draw_set_color(color)
			draw_set_alpha(alpha)
			
			draw_primitive_begin(pr_trianglefan)
			draw_vertex(xpos,ypos)
			
			for(i = 0; i < val; i++)
			{
				len = (i*sizeOfSections) + 90
				tx = lengthdir_x(radius,len)
				ty = lengthdir_y(radius,len)
				draw_vertex(xpos + tx, ypos + ty)
			}
			
			draw_primitive_end()
		}
	}
	
	draw_set_alpha(1)
}