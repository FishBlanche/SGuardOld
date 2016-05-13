/** 
 * Christophe Coenraets, http://coenraets.org
 */
	package controller
	{
		import flash.events.Event;
		import flash.events.TimerEvent;
		import flash.utils.Dictionary;
		import flash.utils.Timer;
		
		import mx.collections.ArrayCollection;
		import mx.core.FlexGlobals;
		import mx.data.DataService;
		import mx.events.PropertyChangeEvent;
		import mx.messaging.ChannelSet;
		import mx.messaging.channels.AMFChannel;
		import mx.rpc.events.ResultEvent;
		import mx.rpc.remoting.RemoteObject;
		
		import components.DataPump;
		import components.DataPumpHelper;
		import components.SensorKind;
		
		import model.SensingEntry;
		public class HistoryFeed
		{
			protected var index:int = 0;
						
			protected var timer:Timer;
			
			protected var senseMap:Dictionary;	
			
			//public var historySensingList1:ArrayCollection;
			[Bindable]
			public var historySensingList:ArrayCollection;
			/*private  var datapump:DataPumpHelper  = new DataPumpHelper();
			private  var datap:DataPump = datapump.getDataPump();*/
			
			private var myAMF:AMFChannel=new AMFChannel();
			private var channelSet:ChannelSet=new ChannelSet();
			private var ds:DataService = new DataService("sql-newest-sensing");
			private var ro:RemoteObject = new RemoteObject();

			public function HistoryFeed()
			{
				senseMap = new Dictionary();
				historySensingList = new ArrayCollection();

				myAMF.url=SensorKind.URL;

				channelSet.addChannel(myAMF); 
				ro.channelSet = channelSet;
				ro.destination = "SensingHistoryService";
				ro.addEventListener(ResultEvent.RESULT,remoteobject1_resultHandler);
			
				//var num:Number=FlexGlobals.topLevelApplication.selectedID;		
				
			}

			public function refresh():void{
				var id:Number=FlexGlobals.topLevelApplication.selectedID;
				ro.getFixedNumberMoteHistoryByMoteIDdesc({MoteID:id,days:2});	
				FlexGlobals.topLevelApplication.GlobalBusy = true;

			}
			
			private function remoteobject1_resultHandler(event:ResultEvent):void{
				historySensingList.removeAll();
				for(var e:Object in event.result ){
					//trace("got the history data");
					var st:SensingEntry = new SensingEntry();
					st.Id = event.result[e].Id;				
					//st.Cluster_id = event.result[e].cluster_id;
					st.Moteid_ID = event.result[e].moteid_ID;
					st.TimestampArrive_TM = event.result[e].timestampArrive_TM;
					st.temperature= event.result[e].temperature;
					st.humidity = event.result[e].humidity;
					st.light = event.result[e].light;	
					st.co2 = event.result[e].co2;	
					st.type = event.result[e].type;
					historySensingList.addItem(st);
				}
			
				FlexGlobals.topLevelApplication.GlobalBusy = false;
				trace("history feed has ok `````");
				
			}

			
		}
	}