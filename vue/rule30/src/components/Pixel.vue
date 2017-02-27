<template>
  <div v-bind:class="{ 'fill': fill == 1, 'pixel': 1, 'blank': fill == -1 }">
  </div>
</template>

<script>
export default {
  name: 'pixel',
  props: [ 'fill' ],
  data () {
    return {
      msg: ''
    }
  }
}
</script>

<style >

.pixel {
  height: 10px;
  width: 10px;
  border: 1px solid black;
  display: inline-block;
}

.fill {
  background-color: black;
}

.blank {
  border: none;
}

</style>
