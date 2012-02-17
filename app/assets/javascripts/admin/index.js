// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require admin/jquery.ui.nestedSortable
//= require twitter/bootstrap
//= require admin/bootstrap
//= require cocoon
//= require admin/uploadify
//= require jquery.lightbox-0.5.min

$(document).ready(function() {
	$("#categories").nestedSortable({
		listType: 'ul',
		opacity: 0.6,
		handle: '.handle',
		items: 'li',
		toleranceElement: '> div',
		update: function(event, ui) {
			var mylist = $('#categories').sortable('serialize');
			var mylist = mylist.replace(/root/g, '');
			var finalstring = '';
			$(mylist.split("&")).each(function(index) {
				string2 = this.split("[");
				type = string2[0];
				string3 = string2[1].split("]");
				id = string3[0];
    			fragments = this.split('=');
    			var parent_id = fragments[1];
    			finalstring = finalstring + type + '[' + index + ']' + '[id]=' + id + '&' + type + '[' + index + '][parent_id]=' + parent_id + '&' + type + '[' + index + '][position]=' + index + '&';
				});
			$.post("/admin/categories/sort", finalstring);
		}
	});
	$('a.lightbox').lightBox();
});