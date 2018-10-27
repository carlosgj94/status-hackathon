<template>
  <div id="create">
    <h1>Create Bond</h1>

    <h2>Authentication</h2>
    <div id="QRCode"></div>
    <div id="my-container"></div>

  </div>
</template>

<script>
import { createRequestQRCode, removeRequestQRCode, RequestData } from '@bloomprotocol/share-kit'

export default {
  name: 'create',
  methods: {
    getQRCode () {
      const requestQRCodeId = createRequestQRCode(this.requestData, document.querySelector('#my-container'), this.options)
      console.log(requestQRCodeId)
    }
  },
  created: function () {
    this.getQRCode()
  },
  components: {
  },
  data () {
    return {
      requestData: {
        action: 'request_attestation_data',
        token: '0x8f31e48a585fd12ba58e70e03292cac712cbae39bc7eb980ec189aa88e24d043',
        url: 'https://bloom.co/api/receiveData',
        org_logo_url: 'https://bloom.co/images/notif/bloom-logo.png',
        org_name: 'Dbonds',
        // org_usage_policy_url: 'https://bloom.co/legal/terms',
        // org_privacy_policy_url: 'https://bloom.co/legal/privacy',
        types: ['full-name', 'company', 'phone', 'email']
      },
      options: {
        size: 200
      }
    }
  }
}
</script>

<style scoped>
#create {
  width: 100%;
}
</style>
