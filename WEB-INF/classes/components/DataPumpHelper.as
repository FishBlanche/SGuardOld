package components
{
	import components.DataPump;
	
	
	import mx.messaging.Consumer;
	public class DataPumpHelper  
	{
		private static var  instance:DataPumpHelper;
		
		private static var  datapump:DataPump;
		public function DataPumpHelper()
		{		
			if(datapump ==null)
				datapump = new DataPump();
		}	
		public function getDataPump():DataPump{
			if(datapump ==null)
				datapump = new DataPump();
			return datapump;
		}
		public function getConsumer():Consumer
		{
			return datapump.getConsumer();
		}
	}
}