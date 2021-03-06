// ActionScript file

package renderers
{
	import flash.text.TextFormat;
	
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	import mx.graphics.SolidColor;
	import mx.states.SetStyle;
	
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.LabelItemRenderer;
	import spark.primitives.Rect;
	
	import components.SensingDataFormat;
	
	import flashx.textLayout.formats.VerticalAlign;
	
	import model.SensingEntry;
	
	public class HistoryRenderer extends LabelItemRenderer
	{
		public var hGroup:HGroup;
		public var Id:Label;
		public var Mote_ID:Label;
		public var Temperature:Label;
		public var Humidity:Label;
		public var Light:Label;
		public var Cluster_id:Label;
		public var Magnetitude:Label;
		public var CO2:Label;
		public var TimestampArrive_TM:Label;
		
/*		[Embed("assets/chart_icon.png")]
		private var chartIconClass:Class;*/
		
		protected var nf:NumberFormatter = new NumberFormatter();
		protected var myDateFormatter:DateFormatter=new DateFormatter();
		
		public function HistoryRenderer()
		{
			super();
			nf.precision = 2;
		}
		
		override public function set data(value:Object):void 
		{
			super.data = value;
			myDateFormatter.formatString="MM/DD HH:NN";
			if (!value) return;
			Mote_ID.text = value.Moteid_ID;
			Temperature.text = SensingDataFormat.temperature(value);
			Humidity.text = SensingDataFormat.humidity(value);
			Light.text = SensingDataFormat.light(value);
			Magnetitude.text =  SensingDataFormat.type(value);
			CO2.text =  SensingDataFormat.co2(value);
			TimestampArrive_TM.text = myDateFormatter.format(value.TimestampArrive_TM);
			
		}
		
		override protected function createChildren():void {
			if (!hGroup) 
			{
				hGroup = new HGroup();
				hGroup.paddingLeft = 0;
				hGroup.paddingRight = 0;
				hGroup.verticalAlign = "middle";
				addChild(hGroup);
			}

			if (!Mote_ID) {
				Mote_ID = new Label();
				Mote_ID.percentWidth = 10;
				hGroup.addElement(Mote_ID);
			}
			

			if (!Humidity) {
				Humidity = new Label();
				Humidity.percentWidth = 20;
				Humidity.setStyle("textAlign", "center");
				hGroup.addElement(Humidity);
			}
			
			if (!Temperature) {
				Temperature = new Label();
				Temperature.percentWidth = 18;
				
				Temperature.setStyle("textAlign", "center");
				hGroup.addElement(Temperature);
			}
			if (!Light) {
				Light = new Label();
				Light.percentWidth = 18;
				Light.setStyle("textAlign", "center");
				hGroup.addElement(Light);
			}
			
			if (!Magnetitude) {
				Magnetitude = new Label();
				Magnetitude.percentWidth = 18;
				Magnetitude.setStyle("textAlign", "center");
				hGroup.addElement(Magnetitude);
			}
			if (!CO2) {
				CO2 = new Label();
				CO2.percentWidth = 18;
				CO2.setStyle("textAlign", "center");
				hGroup.addElement(CO2);
			}
			
			if (!TimestampArrive_TM) {
				TimestampArrive_TM = new Label();
				TimestampArrive_TM.percentWidth = 20;
				TimestampArrive_TM.setStyle("textAlign", "center");
				hGroup.addElement(TimestampArrive_TM);
			}
		}
		
		// Override layoutContents() to lay out the HGroup container.
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			// Make sure our width/height is in the min/max for the label
			var childWidth:Number = unscaledWidth - 6;
			childWidth = Math.max(hGroup.getMinBoundsWidth(), Math.min(hGroup.getMaxBoundsWidth(), childWidth));
			var childHeight:Number = unscaledHeight - 10;
			childHeight = Math.max(hGroup.getMinBoundsHeight(), Math.min(hGroup.getMaxBoundsHeight(), childHeight));
			// Set the label's position and size
			hGroup.setLayoutBoundsSize(childWidth, childHeight);
			hGroup.setLayoutBoundsPosition(3, 5);
		}
	}
}