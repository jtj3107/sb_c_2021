$('select[data-value]').each(function(index, el) {
	const $el = $(el);
	
	const defaultValue = $el.attr('data-value').trim();	

	$el.val(defaultValue);
});

/* 탑바 시작 */
function TopBar__init() {  
  $('.top-bar .btn-show-search-bar').click(function() {
    SearchBar__show();
  });
}
/* 탑바 끝 */

/* 검색바 시작 */
function SearchBar__init() {
  $('.search-bar .btn-hide-search-bar').click(function() {
    SearchBar__hide();
  });
}

function SearchBar__show() {
  $('html').addClass('search-bar-actived');
  $('.search-bar').addClass('active');
  
  setTimeout(function() {
	$('.search-bar form input[name="searchKeyword"]').focus();
	}, 100);
}

function SearchBar__hide() {
  $('html').removeClass('search-bar-actived');
  $('.search-bar').removeClass('active');
  $('.search-bar form input[name="searchKeyword"]').val('');
}
/* 검색바 끝 */

TopBar__init();
SearchBar__init();