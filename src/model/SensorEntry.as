package model
{
	import flashx.textLayout.formats.Float;

	[Bindable]
	public class SensorEntry
	{
		private var _id:int;
		private var _userid:int;
		private var _Moteid_ID:int ;	
		private var _type:int;
		private var _Location_X:int;
		private var _Location_Y:int ;
		private var _Latitude:Number;
		private var _longitude:Number;
		private var _remarks:String;
		
		public function SensorEntry()
		{
			id=0;
			userid=0;
			Moteid_ID=0;
			type=0;
			Location_X=0
			Location_Y=0;
			Latitude=0.0;
			longitude=0.0;
			remarks="";
			
			
		}
	/*	public function  SensorEntry(id:int,userid:int,Moteid_ID:int,type:int,Location_X:int,Location_Y:int,Latitude:Number,longitude:Number,remarks:String){
			this.id=id;
		}*/
		
		public function toString():String{
		
			return "id:"+id+"userid:"+userid+"Moteid_ID:"+Moteid_ID+"type:"+type+"Location_X:"+Location_X+"Location_Y:"+Location_Y+"latitude:"+Latitude+"longtitude:"+longitude+"remarks:"+remarks;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get userid():int
		{
			return _userid;
		}

		public function set userid(value:int):void
		{
			_userid = value;
		}

		public function get Moteid_ID():int
		{
			return _Moteid_ID;
		}

		public function set Moteid_ID(value:int):void
		{
			_Moteid_ID = value;
		}

		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}

		public function get Location_X():int
		{
			return _Location_X;
		}

		public function set Location_X(value:int):void
		{
			_Location_X = value;
		}

		public function get Location_Y():int
		{
			return _Location_Y;
		}

		public function set Location_Y(value:int):void
		{
			_Location_Y = value;
		}

		public function get Latitude():Number
		{
			return _Latitude;
		}

		public function set Latitude(value:Number):void
		{
			_Latitude = value;
		}

		public function get longitude():Number
		{
			return _longitude;
		}

		public function set longitude(value:Number):void
		{
			_longitude = value;
		}

		public function get remarks():String
		{
			return _remarks;
		}

		public function set remarks(value:String):void
		{
			_remarks = value;
		}


	}
}