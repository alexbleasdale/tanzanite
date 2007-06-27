import mx.core.UIObject;
import mx.core.UIComponent
import mx.transitions.*;
import mx.transitions.easing.*;
import mx.utils.Delegate;

class SlideBase extends UIComponent
{
	private var _dataProvider:Array
	private var boundingBox:MovieClip;
	private var index:Number;
	private var k:Number;
	private var tempIndex:Number;
	private var container:UIObject;
	private var stack:Array;
	private var loader:MovieClipLoader;
	private var pause:Number;
	private var id:Number;
	private var depth:Number;
	private var tmanager:TransitionManager;
	private var loop:Boolean = true;
	private var _continue:Boolean = true;
	private var _duration:Number;
	
	public var addListener:Function
	public var removeListener:Function
	private var broadcastMessage:Function
	
	function SlideBase()
	{
		AsBroadcaster.initialize(this);
		index = 0;
		k = 0;
		tempIndex = 0;
		depth = 10;
		stack = new Array();
		loader = new MovieClipLoader();
		tmanager = new TransitionManager();
		tmanager.addEventListener("allTransitionsInDone ", this)
		
		loader.addListener(this);
	}
	
	private function init():Void
	{
		super.init()
		boundingBox._visible = false;
	}
	
	private function createChildren():Void
	{
		container = this.createEmptyObject("container",1);
	}
	
	public function start(timeout:Number):Void
	{
		pause = timeout;
		_start();
	}
	
	private function _start():Void
	{
		if(_continue)
		{
			tempIndex = k;
			showImage(dataProvider[k]);
			k++;
			if(k >= dataProvider.length)
			{
				k = 0;
				if(!loop)
				{
					_continue = false;
					broadcastMessage("finish", this);
				}
			}
		}
	}
	
	private function showImage(path:String):Void
	{
		depth++;
		var mc:UIObject = container.createEmptyObject("mc_"+depth, depth);
		var temp:UIObject = mc.createEmptyObject("temp", 1)
		stack.push(mc);
		loader.loadClip(path, temp);
	}
	
	private function onLoadInit(target:MovieClip):Void
	{
		index = tempIndex;
		startTransition(target);
	}
	
	private function startTransition(target:MovieClip):Void
	{		
		throw new Error("Implementation Error");
	}
	
	private function endTransition(tw:Tween):Void
	{
		throw new Error("Implementation Error");
	}
	
	[Inspectable(type="Array")]
	public function set dataProvider(a:Array):Void
	{
		_dataProvider = a;
	}
	
	public function get dataProvider():Array
	{
		return _dataProvider;
	}
	
	public function get selectedIndex():Number
	{
		return index;
	}
	
	[Inspectable(type="Number", defaultValue=500)]
	public function set duration(t:Number):Void
	{
		_duration = t;
	}
	
	public function get duration():Number
	{
		return _duration
	}	
}