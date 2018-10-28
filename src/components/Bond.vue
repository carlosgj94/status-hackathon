<template>
  <b-card>
        <b-row>
          <b-col cols=4>
            <b-card bg-variant="light"
                  header="Audit"
                  class="text-center">
              <p class="card-text">
                <b-progress :value="details.rating" :max="20" variant="secondary"></b-progress>
                <br>
                  <!-- {{ SPgrade }}  -->
                   <button type="button" class="btn btn-secondary btn-sm">{{ details.auditor }}  </button>
              </p>
            </b-card>

          </b-col>
          <b-col cols="8">
            <h3>Bond  <b-badge variant="info">{{details.principal}}  ♦</b-badge></h3> 
            <h5>Interests  <b-badge>{{details.interestRate/100}}  %</b-badge>  </h5>
            <br><br>
            <div slot="" class="text-right" align-v="end"><i>Days left to bit {{Math.floor(details.timeLeft/8640)}} </i></div>
            <div slot="" class="text-right" align-v="end">                  
                <b-button  variant="info" size="sm" v-b-modal.infoModal >Information</b-button>
                <b-button href="#" variant="danger" size="sm" :disabled="!details.timeLeft">Bid</b-button>
                <b-button href="#" variant="warning" size="sm" disabled>Transfert</b-button>
            </div>
          </b-col>
        </b-row>



      </b-card>
      <!-- <b-modal id="infoModal">
        Additionnal INFO
      </b-modal> -->
</template>

<script>
import bond from '../helper/bondHelper'
import grades from '../helper/grades'

export default {
  name: 'bond',
  methods: {},
  beforeCreate: async function () {
    await bond.init()
    // await bond.initAddress(this.addr)

    // this.detailssLength = await LoanRegistry.getLoansLength()
    // this.loansAddresses = await LoanRegistry.getLoans(0)
    // console.log(this.loansAddresses)
  },
  beforeMount: function () {
  },
  mounted: function () {
  },
  props: ['addr', 'details'],
  components: {},
  computed: {
    SPgrade () {
      // const gr= 20-this.info.grade
      // console.log(this.info.grade)
      // return grades["S&PRating"][gr]
    }
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
      infos: this.details

    }
  }
}
</script>

<style scoped>

</style>
