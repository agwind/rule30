webpackJsonp([1,2],[,,function(t,e){},function(t,e,n){n(11);var i=n(1)(n(6),n(14),null,null);t.exports=i.exports},,,function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var i=n(8),s=n.n(i),o=n(13),r=n.n(o);e.default={name:"app",components:{pixel:r.a},data:function(){return{rule:30,ws:void 0,life_history:[]}},methods:{start_life:function(){var t=this;console.log("Start"),"undefined"==typeof this.ws&&(this.ws=new WebSocket("ws://"+document.location.host+"/ws"),this.$root.$data.life_history=[],this.ws.onmessage=function(e){var n=void 0;n=JSON.parse(e.data);var i;i=t.$root.$data.life_history.length;for(var s=0;s<i;s++)t.$root.$data.life_history[s].push(-1),t.$root.$data.life_history[s].unshift(-1);t.$root.$data.life_history.push(n.universe),t.life_history=t.$root.$data.life_history},this.ws.onopen=function(){t.ws.send(s()({cmd:"start",rule:t.rule}))},this.ws.onclose=function(){t.ws=void 0})},stop_life:function(){console.log("Stop"),"undefined"!=typeof this.ws&&(this.ws.send(s()({cmd:"stop"})),this.ws.close,this.ws=void 0)}}}},function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default={name:"pixel",props:["fill"],data:function(){return{msg:""}}}},,,,function(t,e){},function(t,e){},function(t,e,n){n(12);var i=n(1)(n(7),n(15),null,null);t.exports=i.exports},function(t,e){t.exports={render:function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{attrs:{id:"app"}},[n("md-toolbar",[t._v("\n    Cellular Automaton\n  ")]),t._v(" "),n("md-layout",{staticClass:"mainview",attrs:{"md-column":""}},[n("md-layout",{attrs:{"md-row":"","md-align":"start"}},[n("md-input-container",{attrs:{id:"rule"}},[n("label",[t._v("Rule")]),t._v(" "),n("md-input",{directives:[{name:"model",rawName:"v-model",value:t.rule,expression:"rule"}],attrs:{required:""},domProps:{value:t.rule},on:{input:function(e){t.rule=e}}})],1),t._v(" "),n("md-button",{staticClass:"md-raised md-primary",nativeOn:{click:function(e){t.start_life()}}},[t._v("Start")]),t._v(" "),n("md-button",{staticClass:"md-raised md-primary",nativeOn:{click:function(e){t.stop_life()}}},[t._v("Stop")])],1),t._v(" "),n("md-layout",{attrs:{"md-column":""}},[n("div",{attrs:{id:"sandbox"}},t._l(this.life_history,function(e){return n("div",{staticClass:"sandboxrow"},t._l(e,function(t){return n("pixel",{attrs:{fill:t}})}))}))])],1)],1)},staticRenderFns:[]}},function(t,e){t.exports={render:function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{class:{fill:1==t.fill,pixel:1,blank:t.fill==-1}})},staticRenderFns:[]}},,,function(t,e){},function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var i=n(0),s=n.n(i),o=n(3),r=n.n(o),a=n(4),l=n.n(a),u=n(5),d=n.n(u),c=n(2);n.n(c);s.a.use(l.a),s.a.use(d.a);var f={life_history:[]};new s.a({el:"#app",template:"<App/>",components:{App:r.a},data:f})}],[19]);
//# sourceMappingURL=app.d569e37638b33010d740.js.map