// ActionScript file
package controller
{
	import model.SensorEntry;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import components.SensorKind;
	
	public class SensorFeed{
		
		[Bindable]
		public var sensors:ArrayCollection ;
		private var myAMF:AMFChannel=new AMFChannel();
		private var channelSet:ChannelSet=new ChannelSet();
		private var ro:RemoteObject = new RemoteObject();
		
		public function SensorFeed(){
			sensors = new ArrayCollection();
			
			myAMF.url=SensorKind.URL;
			channelSet.addChannel(myAMF); 
			
			ro.channelSet = channelSet;
			ro.destination = "SensorInfoService";
			ro.addEventListener(ResultEvent.RESULT,deploySensor_resultHandler);
			ro.getNodeInfos();
		
		}
		
		public function refresh():void{
			ro.getNodeInfos();

		}
		
		protected function deploySensor_resultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			for(var e:Object in event.result )
			{
			var st:SensorEntry = new SensorEntry();
			st.id = event.result[e].id;
			st.userid=event.result[e].userid;
			st.Moteid_ID=event.result[e].moteid_ID;
			st.type=event.result[e].type;
			st.Location_X=event.result[e].location_X;
			st.Location_Y=event.result[e].location_Y;
			st.Latitude=event.result[e].latitude;
			st.longitude=event.result[e].longitude;
			st.remarks=event.result[e].remarks;
			sensors.addItem(st);
			
			}
			trace("sensors ok```");
		}
	}

}