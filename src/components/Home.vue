<template>
  <div id="home">
    Hello world
  </div>
</template>

<script>
  import LoanRegistry from '../helper/loanRegistryHelper'
  export default {
    name: 'home',
    methods: {
    },
    beforeCreate: function () {
      LoanRegistry.init().then(() => {
        // this.getCurrentGuessesByAddress()
        LoanRegistry.addLoan(
          49,
          '0xbE916B6d3fb4bD6A54D1498C64542B377415C0D6'
        )
      }).catch(err => {
        console.log(err)
      })
    },
    components: {
    }
  }
</script>

<style scoped>
  #home {
    width: 100%;
  }
</style>
