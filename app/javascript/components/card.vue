<template>
  <div>
    <div class="card lists-page-section-list-item shadow hvr-rotate">
      <div class="card-header bg-custom"></div>
      <!-- <div class="card-header" :style="{ 'background-color': background_color }"></div> -->
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
                <li class="nav-item active">
                  <a class="nav-link active" href="#job" data-target="#job" data-toggle="tab">Job Info</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#notes" data-target="#notes" data-toggle="tab">Notes</a>
               </li>
                <li class="nav-item">
                  <a class="nav-link" href="#application" data-target="#application" data-toggle="tab">Application</a>
               </li>
                <li class="nav-item">
                  <a class="nav-link" href="#commute" data-target="#commute" data-toggle="tab">Commute</a>
               </li>
              </ul>
            </div>
            <div class="card-body tab-content modal-body">
              <div class="tab-pane active fade in" id="job">
                <div class="form-label-group">
                  <input v-model="name" id="name" class="form-control"></input>
                  <label for="name">Name</label>
                </div>
                <div class="form-label-group">
                  <input v-model="background_color" id="background_color" type="color"  list="colors" class="form-control"></input>
                  <label for="background_color">Color</label>
                </div>
                <div class="form-label-group">
                  <input v-model="job_position" id="job_position" class="form-control"></input>
                  <label for="job_position">Job position</label>
                </div>
              </div>

              <div class="tab-pane fade in" id="notes">
                <div class="form-label-group">
                  <textarea v-model="description" placeholder="Notes" rows="10" class="form-control"></textarea>
                </div>
              </div>

              <div class="tab-pane fade in" id="application">
                <div class="form-label-group">
                  <input v-model="resume_file" id="resume_file" class="form-control"></input>
                  <label for="resume_file">Resume</label>
                  <textarea v-model="cover_letter" placeholder="Cover Letter" rows="10" class="form-control"></textarea>
                </div>
              </div>

              <div class="tab-pane fade in" id="commute">
                <div class="form-label-group">
                  <iframe src="https://www.google.com/maps/embed?pb=!1m28!1m12!1m3!1d41659.10326362565!2d-123.1289221948661!3d49.26324645814582!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m13!3e3!4m5!1s0x5486717984d4ef63%3A0x695af2b5a31aca7b!2s142+West+Hastings+Street%2C+Vancouver%2C+BC!3m2!1d49.2819605!2d-123.10866039999999!4m5!1s0x54867403b9f84911%3A0x87a0792622cb9034!2s4596+Inverness+St%2C+Vancouver%2C+BC+V5V+4X4%2C+Canada!3m2!1d49.2434623!2d-123.0799797!5e0!3m2!1sen!2sca!4v1518690804054" width="450" height="350" frameborder="0" style="border:0" allowfullscreen></iframe>
                </div>
              </div>

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
      job_position: this.card.job_position,
      description: this.card.description,
      resume_file: this.card.resume_file,
      cover_letter: this.card.cover_letter,
      background_color: this.card.background_color
    }
  },
  methods: {
    closeModal: function(event) {
      if (event.target.classList.contains("modal")) { this.editing = false }
    },

    save: function() {
      var data = new FormData
      data.append("card[name]", this.name)
      data.append("card[job_position]", this.job_position)
      data.append("card[description]", this.description)
      data.append("card[resume_file]", this.resume_file)
      data.append("card[cover_letter]", this.cover_letter)
      data.append("card[background_color]", this.background_color)

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
