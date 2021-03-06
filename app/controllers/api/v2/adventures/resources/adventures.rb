class API::V2::Adventures::Resources::Adventures < API::V2::ApplicationResource
  helpers API::V1::Helpers

  resource "adventures" do
    desc "Version"
    get "version" do
      results = { version: "v2" }
      present results
    end
    desc "Get All"
    get "/" do
      results   = [{ id: 1, title: "Hello World" }, { id: 2, title: "Hello World 2" }, { id: 3, title: "Hello World 3" },]
      resources = paginate(results)
      present_metas resources
      present :adventures, resources, with: API::V1::Adventures::Entities::Adventure
    end
    desc "Get by id"
    params do
      requires :id, type: Integer
    end
    get "/show" do
      results = [{ id: 1, title: "Hello World" }, { id: 2, title: "Hello World 2" }, { id: 3, title: "Hello World 3" },]
      present :adventure, results[params.id - 1], with: API::V2::Adventures::Entities::Adventure
    end
    desc "Create"
    params do
      requires :title, type: String
    end
    post "/" do
      results = { id: 4, title: params.title }
      present :adventure, results, with: API::V2::Adventures::Entities::Adventure
    end
    desc "Update"
    params do
      requires :id, type: Integer
      requires :title, type: String
    end
    put "/" do
      error!("Can't find id #{params.id}", 422) unless [1, 2, 3].include?(params.id)
      results = { id: params.id, title: params.title }
      present :adventure, results, with: API::V2::Adventures::Entities::Adventure
    end
    desc "Delete"
    params do
      requires :id, type: Integer
    end
    delete "/" do
      error!("Can't find id #{params.id}", 422) unless [1, 2, 3].include?(params.id)

      present "success deleted data with id #{params.id}"
    end


  end
end
