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
              </b-card
              <br>
            </b-row>
            <b-row>
         
              <!-- <b-pagination class="mx-auto" size="md" :total-rows="100" v-model="currentPage" :per-page="10">
              </b-pagination> -->
            </b-row>
          </b-col>
          <b-col></b-col>
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
  }
  #listBody {
    background-color: linear-gradient(45deg,#FFF, #17a2b8);
    
  }
  .loancard {
    width:100%;
  }
</style>
