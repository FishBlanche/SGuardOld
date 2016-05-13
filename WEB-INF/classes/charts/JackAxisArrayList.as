package charts
{
	import mx.collections.ArrayList;
    
    public class JackAxisArrayList extends ArrayList
    {
		public var _allSource:Array = new Array;
		public function get allSource():Array
		{
			return _allSource;
		}
		public function set allSource(a:Array):void
		{
			_allSource = a;
			
			update();
		}
        private var _max:Number = 100;       
        
        private var _step:Number = 10;
        public function get step():Number
        {
            return _step;
        }
        public function set step(value:Number):void
        {
            _step = value;
            update();
        }
        
        private function update():void
        {
            var arr:Array = [];
            var i:Number;
			var alltime:Number;
			var time:Number;
			var righttime:Number=_allSource[_allSource.length-1];
			var lefttime:Number=_allSource[0];
            //if (step > 0)
            //{
			alltime=Math.abs(_allSource[_allSource.length-1]-_allSource[0]);
			time=Math.round(alltime/step);
            for (i = 0; i < alltime; i += time)
            {
                arr.push(new Date(lefttime+i));
					//arr.unshift(new Date(righttime - i));
					
            }
           // }
           // else
           // {
            //    for (i =alltime; i > 0; i -= time)
            //    {
            //        arr.push(new Date(righttime+alltime-i));
            //    }
            //}
			
            source = arr;
			
        }
        
		/*private function update():void
		{
			var arr:Array = [];
			var i:Number;
			if (step > 0)
			{
				for (i = 0; i < _allSource.length; i += step)
				{
					arr.push(_allSource[i]);
				}
			}
			else
			{
				for (i = _allSource.length-1; i > 0; i += step)
				{
					arr.push(_allSource[i]);
				}
			}
			source = arr;
		}*/
    }
}
