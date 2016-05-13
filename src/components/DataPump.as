package components
{	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayList;
	import mx.core.FlexGlobals;
	import mx.data.DataService;
	import mx.messaging.ChannelSet;
	import mx.messaging.Consumer;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.channels.StreamingAMFChannel;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.IMessage;
	import mx.rpc.http.HTTPService;
	import mx.utils.StringUtil;
	
	import components.SensorKind;
	
	import model.SensingEntry;

	public class DataPump  extends EventDispatcher
	{
		public var isConnected:Boolean = false;
		public static var NAME_CHANGED:String="nameChanged";
		//all the buffer are located here, from which data for showing is extracted.
	//	public  var sensingBuf:Array = new Array();
		[Bindable]
		public  var newestSensing:SensingEntry = new SensingEntry();
		private var consumer:Consumer=new Consumer();  
		//private var myStreamingAMF:StreamingAMFChannel=new StreamingAMFChannel();
		private var myAMF:AMFChannel=new AMFChannel();
		private var channelSet:ChannelSet=new ChannelSet();
		private var subscribetimes:int=0;
		
		
		public function DataPump()
		{		

			//myAMF.url="http://s.sensehuge.com:8400/1/messagebroker/amf";
			myAMF.url = IPWindow.serverAddress.getProperty("serverAddress") as String;
			if(myAMF.url == null ){
				myAMF.url = "http://s.sensehuge.com:8400/dataservices-samples/messagebroker/amf";
			}
			channelSet.addChannel(myAMF); 
			
			consumer.destination="feed";  
			consumer.subtopic="LiveSensing";  
			
			consumer.channelSet=channelSet;  
			consumer.addEventListener(MessageEvent.MESSAGE, messageHandler);  
			consumer.addEventListener(ChannelFaultEvent.FAULT, fault);  
			consumer.addEventListener(ChannelEvent.CONNECT, connected); 
			consumer.addEventListener(MessageFaultEvent.FAULT, fault2);  
			consumer.subscribe();
		}
		
		public function getConsumer():Consumer
		{
			return consumer;
		}
		public function refresh():void
		{
			consumer.subscribe();
		}
		private function messageHandler(event:MessageEvent):void  
		{  
		//	trace("---message----"+event.message.body.toString());
		//	trace("new message::"+event.message.body);
			//if(FlexGlobals.topLevelApplication.userState=="登录|注册") return;
			var entyArray:Array =  StringUtil.trim(event.message.body.toString()).split("|");
			for (var entry:String in entyArray)
			{
				if(entyArray[entry].length< 2) continue;
				var ea:Array = entyArray[entry].split(",");
			//	var e:SensingEntry = new SensingEntry();
				newestSensing.Id = parseInt(ea[0]);
				newestSensing.Cluster_id = parseInt(ea[1]);
				newestSensing.Moteid_ID = parseInt(ea[2]);
				//e.TimestampArrive_TM = parseUTCDate(ea[3]);
				newestSensing.TimestampArrive_TM = castMethod1(ea[3]);
				newestSensing.temperature = parseFloat(ea[4]);
				newestSensing.humidity = parseFloat(ea[5]);
				newestSensing.light = parseFloat(ea[6]);	
				newestSensing.co2 = parseFloat(ea[7]);
				newestSensing.type =parseInt(ea[8]);
				newestSensing.path = ea[9];
			//	sensingBuf.push(e);		
			//	newestSensing = e;
			//	trace("-----newestSensing coming-");  
				FlexGlobals.topLevelApplication.selectedID=Number(newestSensing.Moteid_ID );

				dispatchEvent(new Event("_newSensingData"));
			//	trace("event _newSensingData issued");
			//	trace("sensingBuf.length="+sensingBuf.length);
				//trace("feed.newestSensingList.length="+FlexGlobals.topLevelApplication.feed.newestSensingList.length);
			}
			
		}  
		private function castMethod1(dateString:String):Date {
			if ( dateString == null ) {
				return null;
			}
			
			var year:int = int(dateString.substr(0,4));
			var month:int = int(dateString.substr(5,2));
			var day:int = int(dateString.substr(8,2));
			
			if ( year == 0 && month == 0 && day == 0 ) {
				return null;
			}
			
			if ( dateString.length == 10 ) {
				return new Date(year, month, day);
			}
			
			var hour:int = int(dateString.substr(11,2));
			var minute:int = int(dateString.substr(14,2));
			var second:int = int(dateString.substr(17,2));
		//	trace(">"+year+ month+day+ hour+ minute+ second);
			return new Date(year, month, day, hour, minute, second);
		}
		private function parseUTCDate( str : String ) : Date {
			var matches : Array = str.match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d.\d)Z/);
			
			var d : Date = new Date();
			
			d.setUTCFullYear(int(matches[1]), int(matches[2]) - 1, int(matches[3]));
			d.setUTCHours(int(matches[4]), int(matches[5]), int(matches[6]), 0);
			return d;
		}
		
		
		private function connected(e:ChannelEvent):void  
		{			 
			trace("---connected----");
		}  
		
		
		private function fault(e:ChannelFaultEvent):void  
		{  
			trace("---channel fault----");
			var timer:Timer = new Timer(5000,1);
			timer.addEventListener(TimerEvent.TIMER,timer_Handler);
			timer.start();
			//consumer.unsubscribe();

			//consumer.subscribe();
			
		}  
		
		protected function timer_Handler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			consumer.subscribe();
		}
		
		private function fault2(e:MessageFaultEvent):void  
		{  
			trace("---message fault----");
		var timer:Timer = new Timer(5000,1);
			timer.addEventListener(TimerEvent.TIMER,timer_Handler);
			timer.start();

			//consumer.subscribe();
		}  
		
		
		
	}  

}	
	
