<template>
  <div id="home">
      <b-container id="listBody"> 
        <b-row>
          <b-col></b-col>     
          <b-col sm="8">
            <b-row>
              <b-card class="text-center mxauto loancard">
                LOAN
              </b-card>
              <b-card class="text-center mxauto loancard">
                LOAN
              </b-card>
              <br>
            </b-row>
          </b-col>
          <b-col></b-col>
        </b-row>
        <b-row align-v="end">
      
          <!-- <b-pagination class="mx-auto" size="md" :total-rows="100" v-model="currentPage" :per-page="10">
          </b-pagination> -->
        </b-row>
      </b-container>

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
      console.log(await LoanRegistry.getLoansLength())
      console.log(await LoanRegistry.getLoans(0))
      
    },
    components: {
    },
    data () {
      return {
        currentPage: 1
      }
    }
  }
</script>

<style scoped>
  #home {
    width: 100%;
    /* height: 100vh; */
  }
  #listBody {
    background-color: #000; 
    height: 100%;
    min-height: 90vh;
    /* radial-gradient(#17a2b8, #FFF, #FFF); */
    
  }
  .loancard {
    width:100%;
  }
</style>
