//Title : Trig equations
//Version : 3
//Author : Phil Douglas
//angles from sides
//sides from angles
//sides from sides
//angles from points
package com.lookmum.util{
	import flash.geom.Point;
	public class Trig
	{
		public static function angleOppHyp (opp : Number, hyp : Number) : Number
		{
			var angle : Number = Math.asin (opp / hyp) * (180 / Math.PI);
			return angle;
		}
		public static function angleHypOpp (hyp : Number, opp : Number) : Number
		{
			return angleOppHyp (opp, hyp);
		}
		public static function angleAdjHyp (adj : Number, hyp : Number) : Number
		{
			var angle : Number = Math.acos (adj / hyp) * (180 / Math.PI);
			return angle;
		}
		public static function angleHypAdj (hyp : Number, adj : Number) : Number
		{
			return angleAdjHyp (adj, hyp);
		}
		public static function angleOppAdj (opp : Number, adj : Number) : Number
		{
			var angle : Number = Math.atan (opp / adj) * (180 / Math.PI);
			return angle;
		}
		public static function angleAdjOpp (adj : Number, opp : Number) : Number
		{
			return angleOppAdj (opp, adj);
		}
		public static function oppHypAngle (hyp : Number, angle : Number) : Number
		{
			var opp : Number = Math.sin (Math.PI / 180 * angle) * hyp;
			return opp;
		}
		public static function oppAngleHyp (angle : Number, hyp : Number) : Number
		{
			return oppHypAngle (hyp , angle );
		}
		public static function oppAdjAngle (adj : Number, angle : Number) : Number
		{
			var opp : Number = Math.tan (Math.PI / 180 * angle) * adj;
			return opp;
		}
		public static function oppAngleAdj (angle : Number, adj : Number) : Number
		{
			return oppAdjAngle (adj, angle);
		}
		public static function adjHypAngle (hyp : Number, angle : Number) : Number
		{
			var adj : Number = Math.cos (Math.PI / 180 * angle) * hyp;
			return adj;
		}
		public static function adjAngleHyp (angle : Number, hyp : Number) : Number
		{
			return adjHypAngle (hyp, angle);
		}
		public static function adjOppAngle (opp : Number, angle : Number) : Number
		{
			var adj : Number = opp / Math.tan (Math.PI / 180 * angle);
			return adj;
		}
		public static function adjAngleOpp (angle : Number, opp : Number) : Number
		{
			return adjOppAngle (opp, angle);
		}
		public static function hypOppAngle (opp : Number, angle : Number) : Number
		{
			var hyp : Number = opp / Math.sin (Math.PI / 180 * angle);
			return hyp;
		}
		public static function hypAngleOpp (angle : Number, opp : Number) : Number
		{
			return hypOppAngle (opp, angle);
		}
		public static function hypAdjAngle (adj : Number, angle : Number) : Number
		{
			var hyp : Number = adj / Math.cos (Math.PI / 180 * angle);
			return hyp;
		}
		public static function hypAngleAdj (angle : Number, adj : Number) : Number
		{
			return hypAdjAngle (adj, angle);
		}
		public static function oppAdjHyp (adj : Number, hyp : Number) : Number
		{
			var opp : Number = Math.sqrt (adj * adj + hyp * hyp);
			return opp;
		}
		public static function oppHypAdj (hyp : Number, adj : Number) : Number
		{
			return oppAdjHyp (adj, hyp);
		}
		public static function adjOppHyp (opp : Number, hyp : Number) : Number
		{
			var adj : Number = Math.sqrt (opp * opp + hyp * hyp);
			return adj;
		}
		public static function adjHypOpp (hyp : Number, opp : Number ) : Number
		{
			return adjOppHyp (opp, hyp);
		}
		public static function hypAdjOpp (adj : Number, opp : Number) : Number
		{
			var hyp : Number = Math.sqrt (adj * adj + opp * opp);
			return hyp;
		}
		public static function hypOppAdj (opp : Number, adj : Number) : Number
		{
			return hypAdjOpp (adj, opp);
		}
		public static function degRad(num:Number):Number{
			return num / (Math.PI / 180);
		}
		public static function radDeg(num:Number):Number{
			return (Math.PI / 180) * num;
		}
		public static  function anglePoint(point:Point):Number {
			var x:Number = point.x
			var y:Number = point.y
			var angle:Number = Trig.degRad(Math.atan( y / x));
			if (x > 0) angle += 90;
			if (x < 0) angle += 270;
			if (x == 0 && y < 0) angle = 0;
			if (x == 0 && y > 0) angle = 180;
			return angle;
		}
		public static  function anglePoints(point1:Point, point2:Point):Number {
			var x:Number = point1.x - point2.x;
			var y:Number = point1.y - point2.y;
			return anglePoint(new Point(x, y));
		}
	}
}
