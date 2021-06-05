---
title: Software
layout: academic
author_profile: true
---

<!-- {% raw %} -->
<div id="app">
    <div>
      <p>Filter to software meeting any of the following criteria:</p>
      <ul>
        <li class="checkboxlist" style="vertical-align:top;">
        Language
        <label class="container">R
            <input type="checkbox" v-model="show.rpkg">
            <span class="checkmark"></span>
        </label>
        <label class="container">Stata
            <input type="checkbox" v-model="show.stata">
            <span class="checkmark"></span>
        </label>
        <label class="container">Online tool
              <input type="checkbox" v-model="show.gui">
              <span class="checkmark"></span>
        </label>
        </li>
        <li class="checkboxlist" style="vertical-align:top;">
        Purpose
            <label class="container">Statistical analysis
                <input type="checkbox" v-model="show.statistics">
                <span class="checkmark"></span>
            </label>
            <label class="container">Data collection
                <input type="checkbox" v-model="show.datacollection">
                <span class="checkmark"></span>
            </label>
        </li>
      </ul>
    </div>
    <div v-for="sof in softw">
        <h2>{{ sof.name }}</h2>
        <ul class="softlist">
          <li>
          {{ sof.description }}
          </li>
          <li>
          <a v-bind:href="sof.link">{{ sof.type }}</a> / {{ sof.domain }}
          </li>
        </ul>
    </div>
</div>
<!-- {% endraw %} -->

<script>
// software list
var sw = [
        {% for ss in site.data.software %}{
          "name": "{{ ss.name }}",
          "description": "{{ ss.description }}",
          "link": "{{ ss.link }}",
          "type": "{{ ss.type }}",
          "domain": "{{ ss.domain }}"
        }{% unless forloop.last %},{% endunless %}
      {% endfor %}];
//vue app
const app = Vue.createApp({
  data: () => ({
    swa: sw,
    show: {
        rpkg: true,
        stata: true,
        gui: true,
        statistics: true,
        datacollection: true,
    },
  }),
  computed: {
    softw: function () {
        var x = [];
        for (i = 0; i < this.swa.length; i++) {
            let add = false;
            if (this.show.rpkg && this.swa[i].type == "R package")
                add = true;
            if (this.show.stata && this.swa[i].type == "Stata module")
                add = true;
            if (this.show.gui && this.swa[i].type == "GUI")
                add = true;
            if (this.show.statistics && this.swa[i].domain == "Statistics")
                add = true;
            if (this.show.datacollection && this.swa[i].domain == "Data collection")
                add = true;
            if (add)
                x.push(this.swa[i]);
        }
        return x
    }
  }
})
app.mount('#app')
</script>
