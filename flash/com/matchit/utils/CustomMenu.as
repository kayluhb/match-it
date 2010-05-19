package com.matchit.utils 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
    import flash.system.*;
	import flash.ui.*;
	/**
	 * @author cbrown
	 */
	public class CustomMenu {
		
		public function CustomMenu(sprite:Sprite) {
			
			var newMenu:ContextMenu = new ContextMenu();
			newMenu.hideBuiltInItems();
			var item:ContextMenuItem = new ContextMenuItem("Copy player info to clipboard", true, true);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onPlayerVersionSelect);
			newMenu.customItems.push(item);
			sprite.contextMenu = newMenu;
		}
		// privates
		private function get reportVersion():String {
            return Capabilities.isDebugger ? "Flash Player debug version" : "Flash Player";
        }
		// event handlers
		private function onPlayerVersionSelect(e:ContextMenuEvent):void {
			
            var details:String = reportVersion + "\n";
            details += (Capabilities.playerType + " (" + Capabilities.version + ")\n");
            details += ("OS: " + Capabilities.os + "\n");
            details += ("Language: " + Capabilities.language + "\n");
            details += ("Resolution: " + Capabilities.screenResolutionX + " x " + Capabilities.screenResolutionY);
            System.setClipboard(details);
        }
	}
}