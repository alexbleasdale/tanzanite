import mx.core.UIObject;
import mx.core.UIComponent
import mx.transitions.*;
import mx.transitions.easing.*;
import mx.utils.Delegate;
import SlideBase

class SlideFader extends SlideBase
{
	
	function SlideFader()
	{
		super();
	}
	private function startTransition(target:MovieClip):Void
	{		
		var tw:Transition = TransitionManager.start(target._parent, {type:Fade, direction:Transition.IN, duration:duration/1000, easing:Regular.easeOut})
		tw.onMotionFinished = Delegate.create(this, endTransition)
		this.broadcastMessage("transitionInStart", this)
	}
	private function endTransition(tw:Tween):Void
	{
		if(stack.length > 2)
		{
			var mc = stack.shift();
			mc.removeMovieClip();
			delete mc;
		}
		id = _global.setTimeout(Delegate.create(this, _start), pause)
	}
}