require "enju_library/engine"

module EnjuLibrary
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def enju_library
      include EnjuLibrary::InstanceMethods
    end
  end

  module InstanceMethods
    private

    def get_library_group
      @library_group = LibraryGroup.site_config
    end

    def get_shelf
      @shelf = Shelf.find(params[:shelf_id], :include => :library) if params[:shelf_id]
    end

    def get_library
      @library = Library.find(params[:library_id]) if params[:library_id]
    end

    def get_libraries
      @libraries = Library.all_cache
    end

    def get_library_group
      @library_group = LibraryGroup.site_config
    end

    def get_bookstore
      @bookstore = Bookstore.find(params[:bookstore_id]) if params[:bookstore_id]
    end

    def get_subscription
      @subscription = Subscription.find(params[:subscription_id]) if params[:subscription_id]
    end
  end
end

ActionController::Base.send(:include, EnjuLibrary)
