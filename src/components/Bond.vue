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
                <b-button href="#" variant="info" size="sm" >Information</b-button>
                <b-button href="#" variant="danger" size="sm" :disabled="!details.timeLeft">Bid</b-button>
                <b-button href="#" variant="warning" size="sm" disabled>Transfert</b-button>
            </div>
          </b-col>
        </b-row>



      </b-card>
</template>

<script>
import bond from "../helper/bondHelper";
import grades from "../helper/grades";

export default {
  name: "bond",
  methods: {},
  beforeCreate: async function() {
    await bond.init()
    // await bond.initAddress(this.addr)
       

    // this.detailssLength = await LoanRegistry.getLoansLength()
    // this.loansAddresses = await LoanRegistry.getLoans(0)
    // console.log(this.loansAddresses)
  },
  beforeMount: function() {
  
  },
  mounted: function() {},
  props: ['addr','details'],
  components: {},
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
  data() {
    return {

    };
  }
};
</script>

<style scoped>

</style>
