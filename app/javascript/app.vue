<template>
  <draggable v-model="lists" :options="{group: 'lists'}" class="board list-dragArea" @end="listMoved">
    <list v-for="(list, index) in lists" :list="list"></list>

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
  },

  methods: {
    startEditing: function() {
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() })
    },

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
      // data.append("list[board_id]", board.id)
      data.append("list[name]", this.message)

      if (this.message == undefined) { return }

      Rails.ajax({
        url: `/boards/34/lists`,
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
