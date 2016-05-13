/** 
 * Christophe Coenraets, http://coenraets.org
 */
package controller
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.events.PropertyChangeEvent;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import components.DataPump;
	import components.DataPumpHelper;
	import components.IPWindow;
	import components.SensorKind;
	
	import model.SensingEntry;

	public class SensingFeed extends EventDispatcher
	{
		protected var index:int = 0;
		
		protected var updateOrder:Array = [6,4,1,7,0,3,2,5]; // used to simulated randomness of updates
		
		protected var timer:Timer;
		
		protected var senseMap:Dictionary;	
		
		
		[Bindable]
		public var newestSensingList:ArrayCollection;
		private  var datapump:DataPumpHelper  = new DataPumpHelper();
		private  var datap:DataPump = datapump.getDataPump();
		
		private var myAMF:AMFChannel=new AMFChannel();
		private var channelSet:ChannelSet=new ChannelSet();
		private var ro:RemoteObject = new RemoteObject();
		
		public function SensingFeed()
		{
			senseMap = new Dictionary();
			newestSensingList = new ArrayCollection();
			//newestSensingList1 = new ArrayCollection();

			datap.addEventListener("_newSensingData",newData);
			
			
			myAMF.url=IPWindow.serverAddress.getProperty("serverAddress") as String;
			if(myAMF.url == null ){
				myAMF.url = "http://s.sensehuge.com:8400/dataservices-samples/messagebroker/amf";
			}
			channelSet.addChannel(myAMF); 
		
			ro.channelSet = channelSet;
			ro.destination = "NewestSensingService";
			ro.addEventListener(ResultEvent.RESULT,ds_resulted);
			ro.getNewestSensings();	
			
			
		}
		
		public function refresh():void{
			ro.getNewestSensings();	
		}
		
		private function property_change(event:Event):void{
			trace("ds property changed `````");
		}
		private function ds_resulted(event:ResultEvent):void{
			
			for(var e:Object in event.result ){
			//	trace("got  the latest data");
				var st:SensingEntry = new SensingEntry();
				st.Id = event.result[e].Id;
				
				st.Cluster_id = event.result[e].cluster_id;
				st.Moteid_ID = event.result[e].moteid_ID;
				st.TimestampArrive_TM = event.result[e].timestampArrive_TM;
				st.humidity = event.result[e].humidity;
				st.temperature= event.result[e].temperature;
				
				st.light = event.result[e].light;
				st.type = event.result[e].type;
				st.co2 = event.result[e].co2;	
				
				newestSensingList.addItem(st);
				
			}
			trace("ds resulted hell`````");
			FlexGlobals.topLevelApplication.GlobalBusy = false;
			//trace(newestSensingList.length);			
			
		}
		protected function newData(event:Event):void{
			var sense:SensingEntry  = datapump.getDataPump().newestSensing;
			
			var stockCount:int = newestSensingList.length;
			for (var k:int = 0; k < stockCount; k++)
			{
				//var s = newestSensingList.getItemAt(k);
				if(newestSensingList.getItemAt(k).Moteid_ID == sense.Moteid_ID){
					//sense.temperature+=100;
					//s = sense;	
					newestSensingList.getItemAt(k).temperature=sense.temperature;
					newestSensingList.getItemAt(k).humidity=sense.humidity;
					newestSensingList.getItemAt(k).light=sense.light;	
					newestSensingList.getItemAt(k).co2=sense.co2;
					newestSensingList.getItemAt(k).type = sense.type;
					newestSensingList.itemUpdated(newestSensingList.getItemAt(k));
					break;
				}
				
			}
			
		}

	}
}