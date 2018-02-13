<template>
  <div>
    <div class="card lists-page-section-list-item shadow hvr-rotate">
      <div class="card-header" style="background-color: 'grey';"></div>
      <div class="card-body" style="cursor: pointer;" @click="editing=true">
        <h6 class="card-title">{{card.name}}</h6>
      </div>

    </div>

    <div v-if='editing' class="modal-backdrop show"></div>

    <div v-if='editing' @click="closeModal" class="modal show" style="display: block">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="card-header">
            <ul class="nav nav-tabs card-header-tabs">
              <li class="nav-item">
                <a class="nav-link active" href="#">Job</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">Company</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">Notes</a>
              </li>
            </ul>
          </div>
          <div class="modal-header">
            <h5 class="modal-title">{{ card.name }}</h5>
          </div>
          <div class="modal-body card-body">
            <input v-model="name" class="form-control"></input>
            <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
          </div>
          <div class="modal-footer">
            <button @click="save" type="button" class="btn btn-custom">Save changes</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['card', 'list'],
  data: function() {
    return {
      editing: false,
      name: this.card.name,
    }
  },
  methods: {
    closeModal: function(event) {
      if (event.target.classList.contains("modal")) { this.editing = false }
    },

    save: function() {
      var data = new FormData
      data.append("card[name]", this.name)

      Rails.ajax({
        url: `/cards/${this.card.id}`,
        type: "PATCH",
        data: data,
        dataType: "json",
        success: (data) => {
          this.editing = false
        }
      })
    },
  }
}
</script>

<style scoped>
</style>
