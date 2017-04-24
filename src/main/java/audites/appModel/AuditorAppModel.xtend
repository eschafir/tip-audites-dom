package audites.appModel

import audites.domain.Department
import audites.domain.Revision
import audites.domain.User
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable
import java.io.Serializable
import java.util.List
import audites.repos.RepoRevisions

@Observable
@Accessors
class AuditorAppModel extends MainApplicationAppModel implements Serializable {
	Revision toSearch = new Revision
	List<Revision> results
	Set<Department> departments = newHashSet()
	Department departmentSelected
	Revision revisionSelected

	new() {
		super()
		departmentSelected = userLoged.departments.head
		revisionSelected = userLoged.revisions.head
	}

	new(User user) {
		super(user)
		departmentSelected = userLoged.departments.head
		revisionSelected = userLoged.revisions.head
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsNotFinished() {
		revisionSelected != null && !revisionSelected.isCompleted
	}
	@Dependencies("revisionSelected")
	def boolean getRevisionIsSelectedAuditor(){
		revisionSelected != null
	}
	
	def void search() { 
		results = RepoRevisions.instance.search(toSearch.name)
	}
}
