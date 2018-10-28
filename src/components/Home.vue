<template>
  <div id="home">
      <b-container id="listBody"> 
        <b-row>
          <b-col></b-col>     
          <b-col sm="8">
            <div class="text-center"  v-show="loading===true">
                <br><br>
                <h2 class="text-center" style="color:#777">Loading...</h2>
                <br>
                <div  class=" loading-ripple"><div></div><div></div></div>
            </div>
            <div v-show="error">
              {{ error }}
            </div>
            <div v-show="loading===true"  >
              <h1 style="color:white" class="loancardwrapper">Loans</h1>
              <div class=" mxauto loancardwrapper" v-for="loan in loans" :key="loan.contract">
                
                <b-card v-bind:border-variant="loan.color" >
                     {{ loan.borrower }} {{loan.principal}}   <b-badge pill variant="primary">Primary</b-badge>

                     <br>
                     {{ loan.rating }} - {{ loan.auditor }}
                  <br>
                 
                   <b-button href="#" variant="primary">Information</b-button>
                </b-card>
              </div>
            </div>
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
  import bond from '../helper/bondHelper'
// import func from './vue-temp/vue-editor-bridge';
  
  export default {
    name: 'home',
    methods: {     
    },
    beforeCreate: async function () {
        this.error = this.loansAddresses = null
        // await LoanRegistry.init()

        // this.loansLength = await LoanRegistry.getLoansLength()
        // this.loansAddresses = await LoanRegistry.getLoans(0)
        // console.log(this.loansAddresses)        
    },
    beforeMount: function () {
        this.loans = []; // weirdly useful
        this.loans[0] = {
          contract: "0x59d4d9c24cd9517724bce24666bde8aeb27b7d54",
          lender : null,
          borrower : 7890,
          borrowerAddress: "0xc66bD3780C297Baa1d910923c8b47Dce4b284076",
          principal: 80808288,// in cents
          bidTimeFrame: 88855888,
          color: "",
          amountRepaid: 0,
          complete: false,
          defaulted : false,
          creationDate: 1540685256529,
          duration : 2,
          interestRate: 434,
          granted: false,
          rating: 14,
          auditor: "S&P",
        }
        this.loans[1] = {
          contract: "0x475e843c9771e287b65b7189b95d7261edcee1c8",
          lender : null,
          borrower : 38523,
          borrowerAddress: "0x8D55ac7cFD01d50D48F0C3B257584181e144B51F",
          principal: 3432,
          bidTimeFrame: 55534332,
          amountRepaid: 0,
          color:"",
          complete: false,
          defaulted : false,
          creationDate: 1540685256509,
          duration : 4,
          interestRate: 234,
          granted: false,
          rating: 20,
          auditor: "His Grandma",
        }

        this.loans[2] = {
          contract: "0x89b95d7261edcee1c8475e843c9771e287b65b71",
          lender : 898983773,
          borrower : 38523,
          borrowerAddress: "0xD48F0C3B257584181e144B51F8D55ac7cFD01d50",
          principal: 735433,
          bidTimeFrame: 34234,
          amountRepaid: 0,
          color:"secondary",
          complete: false,
          defaulted : false,
          creationDate: 1540685255509,
          duration : 4,
          interestRate: 234,
          granted: false,
          rating: 12,
          auditor: "Registered Auditor Associates",
        }

        this.loans[3] = {
          contract: "0xb65b7189b95d7261edcee1c8475e843c9771e287",
          lender : null,
          borrower : 38383883,
          borrowerAddress: "0xD48F0C3B257584181e144B51F8D55ac7cFD01d50",
          principal: 3432,
          bidTimeFrame: 2,
          amountRepaid: 0,
          color:"danger",
          complete: false,
          defaulted : false,
          creationDate: 1540685236509,
          duration : 4,
          interestRate: 234,
          granted: false,
          rating: 5,
          auditor: "Some Auditor",
        }

      setTimeout(function () {
        this.loading = false 
        console.log("left loading", this.loading)
      }, 3000)

      setTimeout(function () {
        console.log("Loading is now ", this.loading)
      }, 4000)
        // for (let i = 0; i < this.loansAddresses.length; i++) {
        //   this.loans[i] = await bond.getthis.loansAddresses[i];
          
        // }
   
      
    },
    mounted: function() {

    },
    components: {
    },
    computed: {
        // colorLoan: function () {
        // console.log(this)
        // const now = + new Date()
        // console.log(this.creationDate + this.bidTimeFrame - now)
        // console.log(this)
        // if(this.creationDate + this.bidTimeFrame - now>0){
        //   return "";
        // } else 
        // if (this.lender) {
        //   return "primary"
        // } else {
        //   return "danger"
        // }
      // }
    },
    data () {
      return {
        currentPage: 1,
        loading: true,
        error: null,
        loansAddresses: null,
        // loansLength:null,
        loans:[],
        registry: null
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
  .loancardwrapper {
    width:100%;
    margin: 1rem;
  }

  /* ## Spinner ## */
  .loading-ripple {
  display: inline-block;
  position: relative;
  width: 64px;
  height: 64px;
  }
  .loading-ripple div {
    position: absolute;
    border: 4px solid #fff;
    opacity: 1;
    border-radius: 50%;
    animation: loading-ripple 1s cubic-bezier(0, 0.2, 0.8, 1) infinite;
  }
  .loading-ripple div:nth-child(2) {
    animation-delay: -0.9s;
  }
  @keyframes loading-ripple {
    0% {
      top: 28px;
      left: 28px;
      width: 0;
      height: 0;
      opacity: 1;
    }
    100% {
      top: -1px;
      left: -1px;
      width: 58px;
      height: 58px;
      opacity: 0;
    }
  }




</style>
