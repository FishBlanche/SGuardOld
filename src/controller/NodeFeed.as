// ActionScript file
package controller
{
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import components.IPWindow;
	import components.SensorKind;
	
	import model.NodeEntry;
	
	public class NodeFeed{
		
		[Bindable]
		public var nodes:ArrayCollection ;
		private var myAMF:AMFChannel=new AMFChannel();
		private var channelSet:ChannelSet=new ChannelSet();
		private var ro:RemoteObject = new RemoteObject();
		
		public function NodeFeed(){
			nodes = new ArrayCollection();
			
			myAMF.url=IPWindow.serverAddress.getProperty("serverAddress") as String;
			trace(myAMF.url);
			if(myAMF.url == null ){
				myAMF.url =  "http://s.sensehuge.com:8400/dataservices-samples/messagebroker/amf";
			}
			channelSet.addChannel(myAMF); 
			
			ro.channelSet = channelSet;
			ro.destination = "NodeInfoService";
			ro.addEventListener(ResultEvent.RESULT,deploySensor_resultHandler);
			ro.getNodeList();
		
		}
		
		public function refresh():void{
			ro.getNodeInfos();

		}
		
		protected function deploySensor_resultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			for(var e:Object in event.result )
			{

			var st:NodeEntry = new NodeEntry();
			
			st.Moteid_ID=event.result[e].moteid_ID.toString();
			//trace("---"+event.result[e].moteid_ID+"---");
			st.NodeType=event.result[e].nodeType;
			//trace(event.result[e].nodeType);
			st.Location_X=event.result[e].location_X;
			st.Location_Y=event.result[e].location_Y;
			st.Latitude=event.result[e].latitude;
			st.longitude=event.result[e].longitude;
			st.remarks=event.result[e].remarks;

			
			nodes.addItem(st);
			}
			trace("nodes ok```"+nodes.length);
		}
	}

}