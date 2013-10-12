namespace :html2haml do
        desc "Convert *.erb to *.haml"
        task :convert do
                `find . -name \*.erb -print | sed 'p;s/.erb$/.haml/' | xargs -n2 html2haml`
        end

        desc "Remove *.erb"
        task :clean do
                `find . -name \*.erb -print | xargs -n2 rm`
        end
end
