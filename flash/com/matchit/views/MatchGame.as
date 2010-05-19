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
		private static const OFFSET_X:Number = 20;
		private static const OFFSET_Y:Number = 20;
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
		private var restartTimer:Timer;
		private var startTimer:Timer;
		
		private var POLL:Number = 6000;
		
		public function MatchGame() 
		{
			visible = false;
		}
		
		// publics
		public function endGame():void 
		{
			overlay.hide();
			cardBorder.hide();
			restartTimer.start();
		}
		
		public function hide():void 
		{
			new TweenLite(this, .6, { y: -260, onComplete:onHide } );
		}
		
		public function init():void 
		{
			var h:Number = ROWS * TAR_Y;
			var w:Number = COLS * TAR_X;
			x = OFFSET_X;
			y = OFFSET_Y;
			total = COLS * ROWS;
			
			reveal = new Reveal();
			addChild(reveal);
			reveal.init(h, w);
			
			overlay = new Overlay();
			addChild(overlay);
			overlay.init(h, w);
			
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
			
			startTimer = new Timer(POLL);
			startTimer.addEventListener(TimerEvent.TIMER, onTimerFire);
			
			restartTimer = new Timer(POLL);
			restartTimer.addEventListener(TimerEvent.TIMER, onRestartFire);
		}
		
		public function show():void 
		{
			visible = true;
			overlayMask.reset();
			overlay.show();
			cardBorder.show();
			
			new TweenLite(playButton, .3, { autoAlpha:1, delay:1 } );
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
				c.addEventListener(MatchItEvent.REMOVE, onCardRemove);
				c.addEventListener(MatchItEvent.RESET, onCardReset);
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
				firstCard.remove();
				secondCard.remove();
				
				firstCard = null;
				secondCard = null;
			} 
			else 
			{
				firstCard.reset();
				secondCard.reset();
				
				firstCard = null;
				secondCard = null;
			}
		}
		
		private function shimmer():void 
		{
			for (var i:Number = 0; i < cardContainer.numChildren; ++i) 
			{
				var c:Card = cardContainer.getChildAt(i) as Card;
				c.shimmer(.15 * (i % ROWS) + .1);
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
		
		private function onCardRemove(e:Event):void 
		{
			++cardsRemoved;
			var card:Card = e.target as Card;
			overlayMask.hideCard(card);
			
			// remove the cards that are matched
			cardContainer.removeChild(card);
			
			if (cardContainer.numChildren == 0) endGame();
		}
		
		private function onCardReset(e:Event):void 
		{
			var card:Card = e.target as Card;
			card.enabled = true;
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
		
		private function onRestartFire(e:TimerEvent):void
		{
			restartTimer.stop();
			show();
		}
		
		private function onTimerFire(e:TimerEvent):void
		{
			startTimer.stop();
			dispatchEvent(new Event(MatchItEvent.GAME_START));
		}
	}
}