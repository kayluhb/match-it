package com.matchit.views 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.matchit.events.*;
	import com.matchit.models.Icon;
	import com.matchit.utils.ArrayUtils;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.events.*;
	/**
	 * @author cbrown
	 */
	public class MatchGame extends Sprite
	{
		private static const COLS:int = 4;
		private static const OFFSET_X:Number = 10;
		private static const OFFSET_Y:Number = 10;
		private static const PADDING:Number = 0;
		private static const ROWS:int = 3;
		private static const TAR_X:Number = 90;
		private static const TAR_Y:Number = 80;
		
		private var playButton:BaseButton;
		private var firstCard:Card;
		private var secondCard:Card;
		private var cardBorder:CardBorder;
		private var reveal:Reveal;
		private var overlay:Overlay;
		private var overlayMask:OverlayMask;
		private var cardContainer:Sprite;
		private var revealMask:Sprite;
		
		private var cards:Array;
		private var cardsRemoved:int;
		private var total:int;
		private var startTimer:Timer;
		
		private var START_POLL:Number = 6000;
		
		public function MatchGame() 
		{
			visible = false;
		}
		
		// publics
		public function endGame():void 
		{
			overlay.visible = overlayMask.visible = false;
			new TweenLite(revealMask, .2, { autoAlpha:0 } );
		}
		
		public function hide():void 
		{
			new TweenLite(this, .6, { y: -260, onComplete:onHide } );
		}
		
		public function init():void 
		{
			x = OFFSET_X;
			y = OFFSET_Y;
			total = COLS * ROWS;
			
			reveal = new Reveal();
			addChild(reveal);
			reveal.init();
			
			revealMask = new Sprite();
			revealMask.graphics.beginFill(0xffffff);
			revealMask.graphics.drawRect(0, 0, COLS * TAR_X, ROWS * TAR_Y);
			revealMask.graphics.endFill();
			revealMask.alpha = .5;
			addChild(revealMask);
			
			overlay = new Overlay();
			addChild(overlay);
			overlay.init();
			
			overlayMask = new OverlayMask();
			addChild(overlayMask);
			overlayMask.init(COLS, ROWS, TAR_X, TAR_Y);
			
			overlay.mask = overlayMask;
			
			cardBorder = new CardBorder();
			addChild(cardBorder);
			cardBorder.init(COLS, ROWS, TAR_X, TAR_Y);
			
			cardContainer = new Sprite();
			addChild(cardContainer);
			
			playButton = new PlayButton();
			playButton.alpha = 0;
			playButton.visible = false;
			playButton.addEventListener(ButtonEvent.RELEASE, onPlayClick);
			addChild(playButton);
			
			startTimer = new Timer(START_POLL);
			startTimer.addEventListener(TimerEvent.TIMER, onTimerFire);
		}
		
		public function show():void 
		{
			visible = true;
			TweenLite.to(playButton, .3, { autoAlpha:1, delay:1 } );
			startTimer.start();
		}
		
		public function startGame(data:Array):void 
		{
			cards = data.splice(0, (COLS * ROWS) * .5);
			
			TweenLite.to(playButton, .3, { autoAlpha:0 } );
			
			var placedCards:Array = [];
			var c:Card;
			// create all the cards, position them
			for (var i:Number = 0; i < COLS * ROWS; ++i) 
			{
				c = new Card();
				c.idx = i;
				c.x = i % COLS * TAR_X;
				c.y = Math.floor(i / COLS) * TAR_Y;
				c.addEventListener(ButtonEvent.RELEASE, onCardClick);
				cardContainer.addChild(c);
				c.init();
				
				placedCards[placedCards.length] = c;
			}
			// go through the cards array, select 2 random cards, and assign them the data
			// duplicate and shuffle this array
			var tmp:Array = ArrayUtils.shuffle(placedCards.slice());
			var id:Number = 0;
			for (i = 0; i < cards.length; ++i) 
			{
				var ico:Icon = cards[i] as Icon;
				
				c = tmp[id];
				c.id = ico.id;
				c.icon.gotoAndStop(ico.id + 1);
				++id;
				
				c = tmp[id];
				c.id = ico.id;
				c.icon.gotoAndStop(ico.id + 1);
				++id;
			}
			
			shimmer();
		}
		
		// privates
		private function matchCards():void 
		{
			// compare the two cards
			if (firstCard.id == secondCard.id) 
			{
				new TweenLite(firstCard, .3, { autoAlpha:0, delay:1 } );
				new TweenLite(secondCard, .3, { autoAlpha:0, delay:1, onComplete:onCorrectCards, onCompleteParams:[firstCard, secondCard] } );
				firstCard = null;
				secondCard = null;
				cardsRemoved += 2;
				if (cardsRemoved == total - 2) new TweenLite(cardBorder, .2, { autoAlpha:0 } );
			} 
			else 
			{
				new TweenLite(firstCard.bg, .3, { autoAlpha:0, delay:1 } );
				new TweenLite(firstCard.icon, .3, { autoAlpha:0, delay:1 } );
				new TweenLite(secondCard.bg, .3, { autoAlpha:0, delay:1, overwrite:false } );
				new TweenLite(secondCard.icon, .3, { autoAlpha:0, delay:1, onComplete:resetCards, onCompleteParams:[firstCard, secondCard], overwrite:false } );
				firstCard = null;
				secondCard = null;
			}
		}
		
		private function resetCards(first:Card, second:Card):void 
		{
			first.icon.visible = first.bg.visible = second.icon.visible = second.bg.visible = false;
			first.enabled = second.enabled = true;
		}
		
		private function hideCard(c:Card):void 
		{
			c.hide();
		}
		
		private function shimmer():void 
		{
			for (var i:Number = 0; i < cardContainer.numChildren; ++i) 
			{
				var c:Card = cardContainer.getChildAt(i) as Card;
				new TweenLite(c.hit, .25, { alpha:.5, delay:.15 * (i % ROWS) + .1, onComplete:hideCard, onCompleteParams:[c] } );
			}
		}
		
		// event handlers
		private function onCardClick(e:ButtonEvent):void 
		{
			// grab the card and hide it
			var card:Card = e.target as Card;
			card.click();
			
			// user hasn't selected a card
			if (firstCard == null) 
			{ 
				firstCard = card;
			} // user has selected one card
			else if (secondCard == null) 
			{
				secondCard = card;
				matchCards();
			}
		}
		
		private function onCorrectCards(first:Card, second:Card):void 
		{
			overlayMask.hideCards(first, second);
			
			// remove the cards that are matched
			cardContainer.removeChild(first);
			cardContainer.removeChild(second);
			
			if (cardContainer.numChildren == 0) endGame();
		}
		
		private function onHide():void 
		{
			visible = false;
		}
		
		private function onPlayClick(e:ButtonEvent):void 
		{
			startTimer.stop();
			dispatchEvent(new Event(MatchItEvent.GAME_START));
		}
		
		private function onTimerFire(e:TimerEvent):void
		{
			startTimer.stop();
			dispatchEvent(new Event(MatchItEvent.GAME_START));
		}
	}
}