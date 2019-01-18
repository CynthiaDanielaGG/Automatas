
function detectServAudio(url,flashvars){var audId;var ret=false;org=url;url=parseUrl(url);if(url!=false){if(url['domain'].toLowerCase()=='www.goear.com'){if(/^(\/listen\/)|(\/files\/external\.swf)/i.test(url['path'])){if(audId=(getParamValue(url['query'],'file')||(url['path'].match(/^\/listen\/([0-9a-f]+)/i)||[])[1])){ret={'type':'goear','thumb':_PICS_URL+'/capturas/goear.png','url':'http://www.goear.com/files/external.swf?file='+audId,'x':353,'y':132}}}else{if(audId=(getParamValue(url['query'],'file')||getParamValue(url['query'],'v')||(url['path'].match(/^\/playlist\/([0-9a-f]+)/i)||[])[1])){ret={'type':'goearPlaylist','thumb':_PICS_URL+'/capturas/goearPlaylist.png','url':'http://www.goear.com/files/externalpl.swf?file='+audId,'x':360,'y':210}}}}
if(url['domain'].toLowerCase()=='grooveshark.com'){flashvars=flashvars||url['query'];var mPath=url['path'];if(url['anchor']&&url['anchor'][0]=='!'){mPath=url['anchor'].slice(1);}
if(/^\/playlist\/[^\/]+\/([0-9]+)$/i.test(mPath)){ret={'type':'groovesharkPlaylist','thumb':_PICS_URL+'/capturas/groovesharkList.png','url':'http://grooveshark.com/widget.swf?playlistID='+mPath.match(/^\/playlist\/[^\/]+\/([0-9]+)$/i)[1],'x':250,'y':200}}else if(/^\/widget\.swf$/i.test(url['path'])&&/(playlistID=[0-9]+)|(songIDs=[0-9,]+)/i.test(flashvars)){ret={'thumb':_PICS_URL+'/capturas/groovesharkList.png','x':250,'y':200}
if(/playlistID=/i.test(flashvars)){ret.type='groovesharkPlaylist';ret.url='http://grooveshark.com/widget.swf?'+flashvars.match(/playlistID=([0-9]+)/i)[0];}else{ret.type='groovesharkList';ret.url='http://grooveshark.com/widget.swf?'+flashvars.match(/songIDs=([0-9,]+)/i)[0];}}else if(/^\/songWidget\.swf$/i.test(url['path'])&&/songIDs=[0-9]+/i.test(flashvars)){ret={'type':'grooveshark','thumb':_PICS_URL+'/capturas/grooveshark.png','url':'http://grooveshark.com/songWidget.swf?'+flashvars.match(/songIDs=([0-9]+)/i)[0],'x':250,'y':40}}else if(/^\/s\//i.test(mPath)){ret={'type':'grooveshark','thumb':_PICS_URL+'/capturas/grooveshark.png','url':org,'x':250,'y':40}}}
if(/^((player|p1|w)\.)?soundcloud\.com$/i.test(url['domain'])){var pURL=getParamValue(url['query'],'url');if(pURL){ret={'url':'http://w.soundcloud.com/player/?url='+pURL}
if(/playlist/i.test(pURL)){ret.type='soundcloudPlaylist';}else if(/users/i.test(pURL)){ret.type='soundcloudUser';}else if(/tracks/i.test(pURL)){ret.type='soundcloud';}else{return detectServAudio(decodeURIComponent(pURL));}}else{ret={'url':'https://player.soundcloud.com/player.swf?url='+encodeURIComponent(org.replace(/(^\/+|\/+$)/g,''))}
switch(url['path'].replace(/(^\/+|\/+$)/g,'').split('/').length){case 1:ret.type='soundcloudUser';break;case 2:ret.type='soundcloud';break;case 3:ret.type='soundcloudPlaylist';break;default:ret=false;break;}}
if(ret){ret.url+='&show_comments=false&show_artwork=false&show_playcount=false';switch(ret.type){case'soundcloud':ret.x=400;ret.y=166;ret.thumb=_PICS_URL+'/capturas/soundcloud.png';break;case'soundcloudPlaylist':ret.x=400;ret.y=450;ret.thumb=_PICS_URL+'/capturas/soundcloudPlaylist.png';break;case'soundcloudUser':ret.x=400;ret.y=450;ret.thumb=_PICS_URL+'/capturas/soundcloudUser.png';break;}}}
if(url['domain'].toLowerCase()=='www.ivoox.com'){if(audId=url['path'].match(/^\/playerivoox_((ee|em)_[a-z0-9_]+)\.html$/i)){if(audId[2]=='ee'){ret={'type':'ivoox','thumb':_PICS_URL+'/capturas/ivoox.png','url':'http://www.ivoox.com/playerivoox_'+audId[1]+'.html','x':240,'y':133}}else{ret={'type':'ivooxPodcast','thumb':_PICS_URL+'/capturas/ivooxPodcast.png','url':'http://www.ivoox.com/playerivoox_'+audId[1]+'.html','x':206,'y':182}}}else{if(audId=url['path'].match(/rf_([0-9_]+)\.html$/i)){ret={'type':'ivoox','thumb':_PICS_URL+'/capturas/ivoox.png','url':'http://www.ivoox.com/playerivoox_ee_'+audId[1]+'.html','x':240,'y':133}}else{ret={'type':'ivooxPodcast','thumb':_PICS_URL+'/capturas/ivooxPodcast.png','url':'http://www.ivoox.com'+url['path'],'x':240,'y':133}}}}}
return ret;}
function detectMap(url){var varReturn=false;url=parseUrl(url);if(url!=false){if(url['domain'].indexOf('maps.google')!==-1&&url['query']!=''){var p={ll:getParamValue(url['query'],'ll'),sll:getParamValue(url['query'],'sll'),hnear:getParamValue(url['query'],'hnear'),q:getParamValue(url['query'],'q'),spn:getParamValue(url['query'],'spn'),t:getParamValue(url['query'],'t'),z:getParamValue(url['query'],'z'),cbp:getParamValue(url['query'],'cbp'),vpsrc:getParamValue(url['query'],'vpsrc')}
switch(p.t){case'h':p.t='hybrid';break;case'k':p.t='satellite';break;case'p':p.t='terrain';break;default:p.t='roadmap';break;}
varReturn={'type':'google','obj':'flash','thumb':'http://maps.google.com/maps/api/staticmap?center='+(p['ll']||p['hnear']||p['q']||p['sll'])+'&zoom='+p['z']+'&size=425x350&sensor=false&maptype='+p.t,'url':'http://maps.google.com/?'+url['query']+(getParamValue(url['query'],'output')==''?'&output='+(p.cbp!=''?'sv':'')+'embed':''),'x':425,'y':350}}}
return varReturn;}
function detectServVideo(url){var vidId;var varReturn=false;url=parseUrl(url);if(url!==false){if(url['domain'].indexOf('youtube.com')!==-1||url['domain'].indexOf('youtu.be')!==-1||url['domain'].indexOf('youtube-nocookie.com')!==-1){vidId=(getParamValue(url['query'],'v')||getParamValue(url['anchor'],'!v')||url['path'].replace(/^\/((embed|v)\/)?([^\/]+)$/g,function(x,a,b,c){return c;}));if(vidId!=url['path']){varReturn={'type':'youtube','obj':'flash','thumb':'http://i.ytimg.com/vi/'+vidId+'/default.jpg','url':'http://www.youtube.com/embed/'+vidId+'?rel=0','x':480,'y':360}}}
if(url['domain'].indexOf('metacafe.com')!==-1){vidId=url['path'].replace(/^\/watch\/([0-9]+)\/.*$/g,function(x,y){return y;});if(vidId!=url['path']){varReturn={'type':'metacafe','obj':'flash','thumb':'http://www.metacafe.com/thumb/'+vidId+'.jpg','url':'http://www.metacafe.com/fplayer/'+vidId+'/.swf','x':480,'y':360}}}
if(url['domain'].indexOf('video.google')!==-1){vidId=getParamValue(url['query'],'docid');if(vidId!==false&&url['path']=='/videoplay'){varReturn={'type':'google','obj':'flash','thumb':false,'url':'http://video.google.com/googleplayer.swf?docId='+url['query'].replace(/docid=([0-9]+)/,function(x,y){return y;})+'&hl=en','x':480,'y':360}}}
if(url['domain'].indexOf('dailymotion.com')!==-1){vidId=url['path'].replace(/^.*?\/video\/([a-z0-9]+).*?$/g,function(x,y){return y;});if(vidId!=url['path']){varReturn={'type':'dailymotion','obj':'flash','thumb':'http://www.dailymotion.com/thumbnail/160x120/video/'+vidId,'url':'http://www.dailymotion.com/embed/video/'+vidId,'x':480,'y':360}}}
if(url['domain'].indexOf('vimeo.com')!==-1){vidId=url['path'].replace(/^\/(video\/)?([0-9]+)\/?$/g,function(x,y,z){return z;});if(vidId!=url['path']){varReturn={'id':vidId,'type':'vimeo','obj':'flash','thumb':false,'url':'http://player.vimeo.com/video/'+vidId,'x':480,'y':360}}}}
return varReturn;}
function getParamValue(url,param){url=url.split(/&/);for(var value in url){foo=url[value].split(/=/);if(foo[0]==param){return foo[1];}}
return false;}
function getVimeoData(id,fn){jQuery.getJSON('http://vimeo.com/api/v2/video/'+id+'.json?callback=?',fn);}
function parseUrl(url){var regExp=/^([^:]+):\/\/([^\/]+)\/(.*)$/g;var ini,sheme='',domain='',path='',query='',anchor='',fixed=false;var urlPart=false;if(url.indexOf('//')===0){fixed=true;url='fix:'+url;}
if(url.search(regExp)!==-1){sheme=url.replace(/^([^:]+).*$/g,function(x,y){return y;});domain=url.replace(/^[^:]+:\/\/([^\/]+).*$/g,function(x,y){return y;});path=url.replace(/^[^:]+:\/\/[^\/]+\/(.*)$/g,function(x,y){return y;});ini=path.indexOf('#');if(ini!==-1){anchor=path.slice(ini+1);path=url.slice(0,ini);}
ini=path.indexOf('?');if(ini!==-1){query=path.slice(ini+1);path=path.slice(0,ini);}
if(fixed){sheme=false;}
return{'sheme':sheme,'domain':domain,'path':'/'+path,'query':query,'anchor':anchor};}else{return false;}}