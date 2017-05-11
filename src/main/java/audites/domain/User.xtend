package audites.domain

import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.Set

@Observable
@Accessors
@Entity
class User {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	@Column
	String username

	@Column
	String password

	@Column
	String email

	@ManyToMany(fetch=FetchType.LAZY)
	List<Department> departments = newArrayList()

	@ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	List<Role> roles = newArrayList()

	@ManyToMany(fetch=FetchType.LAZY)
	List<Revision> revisions = newArrayList()

	new() {
		name = ""
		username = ""
		password = ""
		email = ""
	}

	new(String n, String u, String p, String m) {
		name = n
		username = u
		password = p
		email = m
	}

	def void addDepartment(Department dep) {
		if (!departments.contains(dep)) {
			departments.add(dep)
		}
	}

	def void removeDepartment(Department dep) {
		if (departments.contains(dep)) {
			departments.remove(dep)
		}
	}

	def void addRevision(Revision rev) {
		if(!revisions.contains(rev)) revisions.add(rev)
	}

	def List<Revision> getRevisions() {
		for (Department d : departments) {
			for (Revision r : d.revisions) {
				if (!revisions.contains(r)) {
					revisions.add(r)
				}
			}
		}
		return revisions
	}

	def Set<String> getDepartmentsNames() {
		var list = newHashSet()
		for (Department dep : departments) {
			list.add(dep.name)
		}
		list
	}
}
