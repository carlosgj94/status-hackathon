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
    beforeCreate: async function () {
      await LoanRegistry.init()
        // this.getCurrentGuessesByAddress()
      console.log(await LoanRegistry.getLoansLength())
      console.log(await LoanRegistry.getLoans(0))
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
