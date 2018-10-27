<template>
  <div id="topbar">
    <b-navbar toggleable="md" type="dark" variant="info">

      <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
      <b-navbar-brand href="/home">
        <img src="/static/images/share.png" class="d-inline-block align-top" style="height:2rem;" alt="DB">
        D-Bonds
      </b-navbar-brand>

      <b-collapse is-nav id="nav_collapse">

        <b-navbar-nav>
        </b-navbar-nav>

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <b-nav-item href="/Home">List of available bonds</b-nav-item>
          <b-nav-item href="/Create" >Create a new bond</b-nav-item>         
        </b-navbar-nav>

      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
  export default {
    name: 'topbar',
    methods: {
    },
    components: {
    }
  }
</script>

<style scoped>

</style>
