
SimpleNavigation::Configuration.run do |navigation|


  cat = Category.roots
  navigation.items  do |primary|

    primary.dom_class = 'nav nav-list'

      cat.each do |root|
        if root.leaf?
          primary.item "#{root.name}", root.name, category_path(root)
        else
          primary.item :root_cat, root.name, category_path(root)  do  |sub_nav|
            sub_nav.dom_class = 'nav nav-list'
            root.children.each do |sub_cat|
              sub_nav.item :sub_cat, sub_cat.name, category_path(sub_cat)
            end
          end

        end
      end

    end



end