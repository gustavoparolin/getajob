<template>
  <div>
    <div class="card lists-page-section-list-item shadow hvr-rotate">
      <div class="card-header bg-custom"></div>
      <div class="card-body" style="cursor: pointer;" @click="editing=true">
        <h6 class="card-title">{{card.name}}</h6>
      </div>

    </div>

    <div v-if='editing' class="modal-backdrop show"></div>

    <div v-if='editing' @click="closeModal" class="modal show" style="display: block">
      <div class="modal-dialog">
        <div class="modal-content">

          <div class="card text-center">
            <div class="card-header">
              <h5 class="modal-title">{{ card.name }}</h5>
              <br>
              <ul class="nav nav-tabs card-header-tabs">
                <li class="nav-item">
                  <a class="nav-link active" href="#home" data-target="#home" data-toggle="tab">Home</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#profile" data-target="#profile" data-toggle="tab">Profile</a>
               </li>
              </ul>
            </div>
            <div class="card-body tab-content modal-body">
              <div class="tab-pane active fade in" id="home">
                <input v-model="name" class="form-control"></input>
              </div>
              <div class="tab-pane" id="profile">profile tab content</div>
            </div>
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
