<template>
  <!-- create a draggable component, then all children will be draggable -->
  <!-- v-model connects Vue to the Model: lists -->
  <!-- :options - group tell the object to not mix lists and cards -->
  <!-- @end receive the drop event and call the function listMoved -->
  <draggable class="board list-dragArea" v-model="lists" :options="{group: 'lists'}" @end="listMoved">

    <!-- render all lists -->
    <list v-for="(list, index) in lists" :list="list"></list>

    <!-- puts an 'Add List' as the last list of the roll -->
    <div class="list">
      <a v-if="!editing" v-on:click="startEditing" class="btn btn-secondary btn-sm">Add a list...</a>
      <textarea v-if="editing" ref="message" v-model="message" class="form-control mb-1"></textarea>
      <button v-if="editing" v-on:click="createList" class="btn btn-secondary">Add</button>
      <a v-if="editing" v-on:click="editing=false">Cancel</a>
    </div>
  </draggable>
</template>

<script>
import draggable from 'vuedraggable'
import list from 'components/list'

export default {
  components: { draggable, list },

  data: function() {
    return {
      editing: false,
      message: "",
    }
  },

  computed: {
    lists: {
      get() {
        return this.$store.state.lists
      },
      set(value) {
        this.$store.state.lists = value
      },
    },
    board_id: {
      get(){
        return this.$store.state.board_id
      }
    }
  },

  methods: {
    startEditing: function() {
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() })
    },

    // receive the "newIndex" of the element and call the list controller: MOVE via Ajax
    listMoved: function(event) {
      var data = new FormData
      data.append("list[position]", event.newIndex + 1)

      Rails.ajax({
        url: `/lists/${this.lists[event.newIndex].id}/move`,
        type: "PATCH",
        data: data,
        dataType: "json",
      })
    },

    createList: function() {
      var data = new FormData
      data.append("list[name]", this.message)

      if (this.message == undefined) { return }

      Rails.ajax({
        url: `/boards/${this.board_id}/lists`,
        type: "POST",
        data: data,
        dataType: "json",
        success: (data) => {
          this.message = ""
          this.editing = false
        }
      })
    }
  }
}
</script>

<style scoped>
</style>
