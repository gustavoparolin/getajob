<template>
  <div class="list shadow">
    <h5 class="text-center">{{ list.name }}</h5>

    <draggable v-model="list.cards" :options="{ group: 'cards' }" class="card-dragArea" @change="cardMoved">
      <card v-for="card in list.cards" :key="card.id" :card="card" :list="list"></card>
    </draggable>

    <a v-if="!editing" v-on:click="startEditing" class="btn btn-outline-secondary btn-sm">Add a card</a>
    <textarea v-if="editing" ref="message" v-model="message" class="form-control mb-1"></textarea>
    <button v-if="editing" v-on:click="createCard" class="btn btn-secondary btn-sm">Add</button>
    <a v-if="editing" v-on:click="editing=false" class="btn btn-outline-danger btn-sm">Cancel</a>
  </div>
</template>

<script>
import draggable from 'vuedraggable'
import card from 'components/card'

export default {
  components: { card, draggable },
  props: ["list"],

  data: function(){
    return {
      editing: false,
      message: ""
    }
  },

  methods: {
    startEditing: function(){
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() })
    },

    cardMoved: function(event) {
      const evt = event.added || event.moved
      if (evt == undefined) { return }

      const element = evt.element
      const list_index = window.store.state.lists.findIndex((list) => {
        return list.cards.find((card) => {
          return card.id === element.id
        })
      })

      var data = new FormData
      data.append("card[list_id]", window.store.state.lists[list_index].id)
      data.append("card[position]", evt.newIndex + 1)

      Rails.ajax({
        url: `/cards/${element.id}/move`,
        type: "PATCH",
        data: data,
        dataType: "json"
      })
    },

    createCard: function() {
      var data = new FormData
      data.append("card[list_id]", this.list.id)
      data.append("card[name]", this.message)

      if (this.message == undefined) { return }

      Rails.ajax({
        url: `/cards`,
        type: "POST",
        data: data,
        dataType: "json",
        success: (data) => {
          this.message = ""
          this.$nextTick(() => { this.$refs.message.focus() })
        }
      })
    }
  }
}
</script>

<style scoped>
</style>
