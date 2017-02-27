<template>
  <div id="app">
    <md-toolbar>
      Cellular Automaton
    </md-toolbar>
    <md-layout md-column class="mainview">
      <md-layout md-row md-align="start">
          <md-input-container id="rule">
            <label>Rule</label>
            <md-input required v-model="rule"></md-input>
          </md-input-container>
          <md-button class="md-raised md-primary" @click.native="start_life()">Start</md-button>
          <md-button class="md-raised md-primary" @click.native="stop_life()">Stop</md-button>
      </md-layout>
      <md-layout md-column>
        <div id="sandbox">
          <div class="sandboxrow" v-for="life in this.life_history">
            <pixel v-for="cell in life" :fill="cell"></pixel>
          </div>
        </div>
      </md-layout>
    </md-layout>
  </div>
</template>

<script>

import Pixel from './components/Pixel'

export default {
  name: 'app',
  components: {
    'pixel': Pixel,
  },
  data () {
    return {
      rule: 30,
      ws: undefined,
      life_history: []
    }
  },
  methods: {
    start_life() {
      console.log("Start")

      if (typeof this.ws === 'undefined') {
        this.ws = new WebSocket( 'ws://' + document.location.host + '/ws')
        this.$root.$data.life_history = []
        this.ws.onmessage = (event) => {
    			let life
    			life = JSON.parse(event.data)
          var len;
    			len = this.$root.$data.life_history.length;
    			for (var i = 0; i < len ; i++) {
            this.$root.$data.life_history[i].push(-1);
            this.$root.$data.life_history[i].unshift(-1);
          }
    			this.$root.$data.life_history.push(life.universe)
          this.life_history = this.$root.$data.life_history
        }
        this.ws.onopen = () => {
    			this.ws.send(JSON.stringify({ cmd: 'start', rule: this.rule }))
        }
        this.ws.onclose = () => {
          this.ws = undefined
        }
      }
    },
    stop_life() {
      console.log("Stop")
      if (typeof this.ws !== 'undefined') {
  			this.ws.send(JSON.stringify({ cmd: 'stop' }))
        this.ws.close
        this.ws = undefined
      }
    }
  }
}
</script>

<style>

.mainview {
  margin: 20px;
}

#rule {
  width: 65px;
}

.md-button {
  max-height: 40px;
}

#sandbox {
  text-align: center;
  white-space: nowrap;
}

.sandboxrow {
  line-height: 1px;
}

</style>
