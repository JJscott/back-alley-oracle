<template>
  <footer class="footer">
    <div class="inner-flex">
      <div class="footer-legal">
        <p>Portions of Squire are unofficial Fan Content permitted under the Wizards of the Coast Fan Content Policy. The literal and graphical information presented on this site about Flesh & Blood™ TCG, including card images, card symbols, card and rules text, is copyright Legend Story Studios. Squire is not produced by or affiliated in any way with Legend Story Studios.</p>
       <p>All rights reserved, ®'s and ™'s belong to their respective owners.</p>
       <p>All other content © 2020 Squire.</p>
     </div>
    </div>
  </footer>
</template>




<script>
export default {
  name: "the-footer"
};
</script>


<style lang="scss">

.footer{
  background-color: #111;
  box-shadow: 0 0 10px black;
}

.footer-legal {
  p {
    margin: 1rem 0 0 0;
    font-size: 0.75rem;
  }
}
</style>


