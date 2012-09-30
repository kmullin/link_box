// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap

function addShortUrl(asset_id, link_id, url) {
  var content = "<a class=\"download-link\" href=\"" + url + "\">" + link_id + "</a> ";
  $('#asset-' + asset_id + '-links').append(content);
  bindDownloadLinks();
}

function removeShortUrl(url) {
  $('.download-link').each(function(index, value) {
     if ( $(this).attr('href') == url ) {
       $(this).remove();
     }
  });
  return true;
}

function bindDownloadLinks() {
  $(".download-link").bind('click', function() {
    var link_id = $(this).html();
    $.ajax({
      type: 'DELETE',
      url: '/a/url/' + link_id,
      success: function(data) {
        removeShortUrl(data['url']);
      }
    });
    return false;
  });
}

$(document).ready(function() {
  $(".asset-add").bind('click', function() {
    var asset = $(this).attr('id').replace('asset-','');
    $.post('/a/url/', {asset: asset}, function(data) {
      addShortUrl(asset, data['link_id'], data['url']);
    });
  });
  bindDownloadLinks();
});
