<template>
  <div id="listing">
    <div class='cross-background'></div>
      <b-container id="listBody"> 
        <b-row>
          <b-col></b-col>     
          <b-col sm="8">
            <div class="text-center"  v-if="loading">
                <br><br>
                <h2 class="text-center" style="color:#777">Loading...</h2>
                <br>
                <div  class=" loading-ripple"><div></div><div></div></div>
            </div>
            <div v-show="error">
              {{ error }}
            </div>
            <div v-show="!loading">
              <h1 style="color:white" class="loancardwrapper">Unsecured Corporate Bonds</h1>
              <div class=" mxauto loancardwrapper" v-for="loan in loans" :key="loan.contract">
               
               <bond addr="loan.contract" :details="loan"></bond>
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
      <BidModal/>
    </div>
</template>

<script>
import LoanRegistry from '../helper/loanRegistryHelper'
import BondHelper from '../helper/BondHelper'
import bond from './Bond.vue'

export default {
  name: 'listing',
  methods: {
    async getBondsData () {
      for (var loan in this.loansAddresses) {
        if (this.loansAddresses[loan] !== '0x0000000000000000000000000000000000000000') {
          console.log(this.loansAddresses[loan])
          await this.getSingleBond(this.loansAddresses[loan], loan)
        }
      }
    },

    async getSingleBond (address, arrayPosition) {
      await BondHelper.initAddress(address)
      let actualBond = await BondHelper.getBond()
      console.log(actualBond)
      this.loans[arrayPosition] = {
        contract: address,
        lender: actualBond[0].c[0],
        borrower: actualBond[2].c[0],
        borrowerAddress: actualBond[3],
        principal: actualBond[4].c[0], // in cents
        bidTimeFrame: actualBond[5].c[0],
        timeLeft: 200300, // I DON'T HAVE THIS INFORMATION
        color: '',
        amountRepaid: actualBond[6].c[0],
        complete: actualBond[8],
        defaulted: actualBond[7],
        creationDate: actualBond[9].c[0],
        duration: actualBond[10].c[0],
        interestRate: actualBond[11].c[0],
        granted: false, // I DON'T HAVE THIS INFORMATION
        rating: actualBond[12].c[0],
        auditorAddress: actualBond[13],
        auditor: 'S&P'
      }
    }
  },
  beforeCreate: async function () {
    this.error = this.loansAddresses = null
    await LoanRegistry.init()
    await BondHelper.init()

    // this.loansLength = await LoanRegistry.getLoansLength()
    this.loansAddresses = await LoanRegistry.getLoans(0)
    await this.getBondsData()
  },
  beforeMount: function () {
    this.loans[0] = {
      contract: '0x59d4d9c24cd9517724bce24666bde8aeb27b7d54',
      lender: null,
      borrower: 7890,
      borrowerAddress: '0xc66bD3780C297Baa1d910923c8b47Dce4b284076',
      principal: 80808288, // in cents
      bidTimeFrame: 88855888,
      timeLeft: 200300,
      color: '',
      amountRepaid: 0,
      complete: false,
      defaulted: false,
      creationDate: 1540685256529,
      duration: 2,
      interestRate: 434,
      granted: false,
      rating: 14,
      auditor: 'S&P'
    }

    let self = this
    setTimeout(function () {
      self.loading = false
    }, 2000)
  },
  mounted: function () {},
  components: {
    'bond': bond
  },
  computed: {

  },
  data () {
    return {
      currentPage: 1,
      loading: true,
      error: null,
      loansAddresses: null,
      loans: [],
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
  background-color: rgba(0, 0, 0, 0.2);
  height: 100%;
  min-height: 100vh;
  /* radial-gradient(#17a2b8, #FFF, #FFF); */
}
.loancardwrapper {
  width: 100%;
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

.cross-background {
  position: fixed;
  bottom: 0;
  top: 0;
  left: 0;
  right: 0;
  background: -webkit-linear-gradient(
    -45deg,
    rgba(250, 250, 250, 0.9) 45%,
    rgba(55, 230, 235, 1) 0%
  );

  z-index: -2;
}
</style>
