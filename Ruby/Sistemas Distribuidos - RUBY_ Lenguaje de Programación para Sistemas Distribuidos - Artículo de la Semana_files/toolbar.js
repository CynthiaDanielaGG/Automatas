
var MiarrobaToolBar=function($name){var t=this;t.timeout=false;t.loginscript=function(){$mia.login();}
t.mtb_checkform=function(){clearTimeout(t.timeout);var errorMsg='';var input=jQuery('#mtb_search_what');input.val(jQuery.trim(input.val()));if(input.val()=='')errorMsg=errorMsg+'\n+ '+t.mtb_search_error_1;if(errorMsg!=''){if(t.timeout===false)input.unbind('blur');alert('.: ERROR :.\n'+errorMsg);input.trigger('setOneBlur');input.focus();return false}
return true;}
t.init=function(){var div=jQuery('#matb_div_search_form');var form=jQuery('#matb_search_form');var input=jQuery('#mtb_search_what');var boton=jQuery('#mtb_search_submit');var img=jQuery('#mtb_search_img');var span=jQuery('#buscaren');var mouseenter=function(){if(!div.hasClass('formactive')){div.addClass('formover');div.one('mouseleave',function(){div.removeClass('formover');});}}
var click=function(e){img.hide();span.hide();form.show();input.focus();}
div.bind('mouseenter',mouseenter).bind('click',click);var inputAction=function(){input.one('blur',function(){t.timeout=setTimeout(function(){form.hide();img.show();span.show();inputAction();input.val('');t.timeout=false;},200);});}
inputAction();input.bind('setOneBlur',inputAction);}
jQuery(t.init);}
var matb_blink=function(obj){var t=this;t.obj=jQuery(obj);setInterval(function(){t.obj.toggleClass('blinking');},500);}